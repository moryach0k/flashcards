class Card < ActiveRecord::Base
  has_attached_file :image, styles: { medium: "360x360>" }

  validates_attachment_content_type :image, content_type: %r/\Aimage\/.*\Z/

  belongs_to :user
  belongs_to :deck
  validates :original_text, :translated_text, :review_date, presence: true
  validates :user, presence: true
  validates :deck, presence: true
  validate :original_and_translated_text_cannot_be_the_same

  scope :needed_to_review, -> { where("review_date <= ?", Time.current) }

  def update_after_review
    intervals = {1 => 12.hours, 2 => 3.day, 3 => 1.week, 4 => 2.week, 5 => 1.month}
    if self.review_stage <= 5
      time_to_increase = intervals[self.review_stage]
    else
      time_to_increase = intervals.values.last
    end

    self.review_date = Time.current + time_to_increase
    self.review_stage += 1
    self.wrong_attempts = 0
  end

  def reset_review_stage
    if wrong_attempts == 3
      self.wrong_attempts = 0
      self.review_stage = 1
    end
  end

  def correctly_translated(user_original_text)
    damerau_levenshtein_distance = DamerauLevenshtein.distance(original_text.capitalize, user_original_text.capitalize)
    if damerau_levenshtein_distance == 0
      update_after_review
      { correct: true, typos_count: 0 }
    elsif damerau_levenshtein_distance == 1
      update_after_review
      { correct: true, typos_count: 1 }
    else
      self.wrong_attempts += 1
      reset_review_stage
      { correct: false, typos_count: 2 }
    end
  end

  private

  def original_and_translated_text_cannot_be_the_same
    if original_text.casecmp(translated_text) == 0
      errors.add(:original_text, t("card.error.same_texts"))
      errors.add(:translated_text, t("card.error.same_texts"))
    end
  end
end

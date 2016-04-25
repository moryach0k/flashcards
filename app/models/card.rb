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

  def increase_review_date
    time_to_increase = case review_stage
    when 1
      12.hours
    when 2
      3.day
    when 3
      1.week
    when 4
      2.week
    when 5
      1.month
    else
      1.month
    end

    self.review_date = Time.current + time_to_increase
    self.review_stage += 1
    self.wrong_attempts = 0
  end

  def reset_review_date
    if wrong_attempts == 3
      self.wrong_attempts = 0
      self.review_stage = 1
      increase_review_date
    end
  end

  def correctly_translated(user_original_text)
    if original_text.casecmp(user_original_text) == 0
      increase_review_date
      return true
    else
      self.wrong_attempts += 1
      reset_review_date
    end
    false
  end

  private

  def original_and_translated_text_cannot_be_the_same
    if original_text.casecmp(translated_text) == 0
      errors.add(:original_text, "cant be the same")
      errors.add(:translated_text, "cant be the same")
    end
  end
end

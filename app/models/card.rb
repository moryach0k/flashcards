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

  def check_translation(user_original_text, quality_timer)
    supermemo2 = SuperMemo2.new(review_stage, interval, ef, quality_timer.to_i, damerau_levenshtein_distance)
    update_attributes(supermemo2.update_after_review)
  end

  def correctly_translated?(user_original_text)
    damerau_levenshtein_distance < 2 ? true : false
  end

  private

  def original_and_translated_text_cannot_be_the_same
    if original_text.casecmp(translated_text) == 0
      errors.add(:original_text, t("card.error.same_texts"))
      errors.add(:translated_text, t("card.error.same_texts"))
    end
  end

  def damerau_levenshtein_distance
    DamerauLevenshtein.distance(original_text.capitalize, user_original_text.capitalize)
  end
end

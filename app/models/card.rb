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
    dl_distance = DamerauLevenshtein.distance(original_text.capitalize, user_original_text.capitalize)
    supermemo = SuperMemo.new
    card_info = {
      review_stage: review_stage,
      interval: interval,
      ef: ef,
      quality_timer: quality_timer,
      typos_count: dl_distance
    }
    update_attributes(supermemo.execute(card_info))
  end

  def correctly_translated?(user_original_text)
    DamerauLevenshtein.distance(original_text.capitalize, user_original_text.capitalize) < 2
  end

  private

  def original_and_translated_text_cannot_be_the_same
    if original_text.casecmp(translated_text) == 0
      errors.add(:original_text, I18n::t("card.error.same_texts"))
      errors.add(:translated_text, I18n::t("card.error.same_texts"))
    end
  end
end

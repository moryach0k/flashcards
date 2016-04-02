class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_text_cannot_be_the_same

  private
  def original_and_translated_text_cannot_be_the_same
    if original_text.casecmp(translated_text) == 0
      errors.add(:original_text, "cant be the same")
      errors.add(:translated_text, "cant be the same")
    end
  end
end

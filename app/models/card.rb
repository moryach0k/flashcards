class Card < ActiveRecord::Base
  validates :original_text, :translated_text, :review_date, presence: true
  validate :original_and_translated_text_cannot_be_the_same

  scope :needed_to_review, -> { where("review_date <= ?", Time.zone.now.to_date - 3) }

  def increase_review_date
    self.review_date = Date.today + 3
  end

  def correctly_translated(user_original_text)
    if original_text.casecmp(user_original_text) == 0
      increase_review_date
      return true
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

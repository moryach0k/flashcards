require "rails_helper"

RSpec.describe Card, type: :model do
  let!(:user) { create(:user, email: "user@email.com", password: "qwerty") }

  it "returns true if correctly translated" do
    card = user.cards.create!(original_text: "House", translated_text: "Дом", review_date: Date.today)
    expect(card.correctly_translated("HoUse")).to be true
  end

  it "returns false if mistranslated" do
    card = user.cards.create!(original_text: "Dog", translated_text: "Собака", review_date: Date.today)
    expect(card.correctly_translated("cat")).to be false
  end
end

require "rails_helper"

RSpec.describe Card, type: :model do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }

  it "returns true if correctly translated" do
    expect(card.correctly_translated("waTer")).to eq(0)
  end

  it "returns true if translated with typo" do
    expect(card.correctly_translated("woter")).to eq(1)
  end

  it "returns false if mistranslated" do
    expect(card.correctly_translated("cat")).to eq(2)
  end

  it "set review_stage to 6" do
    5.times do
      card.correctly_translated("WATER")
    end
    expect(card.review_stage).to eq 6
  end

  it "set wrong_attempts to 1" do
    card.correctly_translated("dog")
    expect(card.wrong_attempts).to eq 1
  end

  it "reset wrong_attempts" do
    3.times do
      card.correctly_translated("dog")
    end
    expect(card.wrong_attempts).to eq 0
  end
end

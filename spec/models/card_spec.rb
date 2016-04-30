require "rails_helper"

RSpec.describe Card, type: :model do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, user: user, deck: deck) }
  quality_timer = 1

  it "returns true if correctly translated" do
    expect(card.correctly_translated?("waTer")).to be true
  end

  it "returns true if translated with typo" do
    expect(card.correctly_translated?("woter")).to be true
  end

  it "returns false if mistranslated" do
    expect(card.correctly_translated?("cat")).to be false
  end

  it "set review_stage to 6" do
    5.times do
      card.check_translation("WATER", quality_timer)
    end
    expect(card.review_stage).to eq 6
  end

  it "set interval to 1" do
    card.check_translation("WATER", quality_timer)
    expect(card.interval).to eq 1
  end

  it "set interval to 0" do
    card.check_translation("dog", quality_timer)
    expect(card.interval).to eq 0
  end
end

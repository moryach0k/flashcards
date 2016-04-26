require 'rails_helper'
require 'support/check_translation_helper'
require 'support/login_helper'
require 'support/create_card_helper.rb'

describe 'checking translation process' do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }
  let!(:card) { create(:card, deck: deck, user: user) }

  before(:each) do
    login("user@email.com", "qwerty")
  end

  it "checking right creating card" do
    create_card("Water", "Вода")
    expect(page).to have_content "Card was successfully created."
  end

  it "checking right translation" do
    check_translation("water")
    expect(page).to have_content "Right!"
  end

  it "checking wrong translation" do
    check_translation("food")
    expect(page).to have_content "Wrong!"
  end
end
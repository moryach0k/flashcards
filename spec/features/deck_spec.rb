require 'rails_helper'
require 'support/login_helper'
require 'support/deck_helper'

describe 'creating deck process' do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck) }

  before(:each) do
    login("user@email.com", "qwerty")
  end

  it "checking right creating deck" do
    create_deck("Deck")
    expect(page).to have_content "Card was successfully created."
  end
end
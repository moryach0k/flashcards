require 'rails_helper'
require 'support/login_helper'
require 'support/create_deck_helper'

describe 'creating deck process' do
  let!(:user) { create(:user) }
  let!(:deck) { create(:deck, user: user) }

  before(:each) do
    login("user@email.com", "qwerty")
  end

  it "checking right creating deck" do
    create_deck("Deck")
    expect(page).to have_content "Deck was successfully created."
  end
end
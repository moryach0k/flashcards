require 'rails_helper'
require 'support/check_translation_helper'
require 'support/login_helper'

describe 'checking translation process' do
  let!(:user) { create(:user, email: "user@email.com", password: "qwerty", password_confirmation: "qwerty") }
  let!(:card) { create(:card, original_text: "Water",
                              translated_text: "Вода",
                              review_date: Date.today,
                              user: user) }

  before(:each) do
    login("user@email.com", "qwerty")
  end

  it "checking right translation" do
    check_translation("water")
    expect(page).to have_content "Правильно!"
  end

  it "checking wrong translation" do
    check_translation("food")
    expect(page).to have_content "Неправильно!"
  end
end
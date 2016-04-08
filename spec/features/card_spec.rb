require 'rails_helper'

describe 'checking translate'  do

  before(:each) do
    card = create(:card, original_text: "Water",
    translated_text: "Вода",
    review_date: Date.today)
  end

  it "checking translation" do
    visit root_path
    fill_in "user_original_text", with: "water"
    click_button "Проверить"
    expect(page).to have_content "Правильно!"
  end

end
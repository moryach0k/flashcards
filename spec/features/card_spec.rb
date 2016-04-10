require 'rails_helper'
require 'support/check_translation_helper'

describe 'checking translate' do
  let!(:card) { create(:card, original_text: "Water",
                              translated_text: "Вода",
                              review_date: Date.today) }

  it "checking right translation" do
    check_translation("water")
    expect(page).to have_content "Правильно!"
  end

  it "checking wrong translation" do
    check_translation("food")
    expect(page).to have_content "Неправильно!"
  end
end
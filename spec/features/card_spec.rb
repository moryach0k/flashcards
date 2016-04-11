require 'rails_helper'
require 'support/check_translation_helper'

describe 'checking translation process' do
  before(:each) do
    @user = create(:user, email: "user@email.com", password: "qwerty")
  end
  let!(:user) { create(:card, original_text: "Water",
                              translated_text: "Вода",
                              review_date: Date.today,
                              user_id: @user.id) }

  it "checking right translation" do
    check_translation("water")
    expect(page).to have_content "Правильно!"
  end

  it "checking wrong translation" do
    check_translation("food")
    expect(page).to have_content "Неправильно!"
  end
end
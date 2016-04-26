require 'rails_helper'
require 'support/login_helper'
require 'support/registration_helper'

describe 'login process' do
  let!(:user) { create(:user) }

  it "checking right login" do
    login("user@email.com", "qwerty")
    expect(page).to have_content I18n.t("notice.logged_in")
  end

  it "checking wrong login_password" do
    login("user@email.com", "qwe")
    expect(page).to have_content I18n.t("alert.login_failed")
  end

  it "checking wrong login_email" do
    login("wrong_user@email.com", "qwerty")
    expect(page).to have_content I18n.t("alert.login_failed")
  end
end

describe 'registration process' do
  it "checking right registration" do
    registration("user@email.com", "qwerty", "qwerty")
    expect(page).to have_content I18n.t("user.created")
  end

  it "checking wrong registration" do
    registration("user@email.com", "qwerty", "qwe")
    expect(page).to have_content I18n.t("user.wrong_registration_info")
  end
end
require 'rails_helper'
require 'support/login_helper'
require 'support/registration_helper'

describe 'login process' do
  let!(:user) { create(:user, email: "user@email.com", password: "qwerty", password_confirmation: "qwerty") }

  it "checking right login" do
    login("user@email.com", "qwerty")
    expect(page).to have_content "Login successful!"
  end

  it "checking wrong login_password" do
    login("user@email.com", "qwe")
    expect(page).to have_content "Login failed!"
  end

  it "checking wrong login_email" do
    login("wrong_user@email.com", "qwerty")
    expect(page).to have_content "Login failed!"
  end
end

describe 'registration process' do
  it "checking right registration" do
    registration("user@email.com", "qwerty", "qwerty")
    expect(page).to have_content "User was successfully created."
  end

  it "checking wrong registration" do
    registration("user@email.com", "qwerty", "qwe")
    expect(page).to have_content "Wrong registration information."
  end
end
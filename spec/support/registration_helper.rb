def registration(email, password, password_confirmation)
  visit root_path
  click_link "registration"
  fill_in :user_email, with: email
  fill_in :user_password, with: password
  fill_in :user_password_confirmation, with: password_confirmation
  click_button "registration_button"
end
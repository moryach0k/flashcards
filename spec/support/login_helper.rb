def login(email, password)
  visit root_path
  click_link "login"
  fill_in :email, with: email
  fill_in :password, with: password
  click_button "login_button"
end
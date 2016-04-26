def check_translation(translation)
  visit root_path
  fill_in "user_original_text", with: translation
  click_button "Check"
end
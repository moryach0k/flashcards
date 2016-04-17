def create_card(original_text, translated_text)
  visit root_path
  click_link "add_card"
  fill_in "card_original_text", with: original_text
  fill_in "card_translated_text", with: translated_text
  page.attach_file("card_image", Rails.root + "public/system/cards/images/img.jpg")
  click_button "add_card_btn"
end
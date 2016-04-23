def create_deck(name)
  visit root_path
  click_link "decks"
  click_link "add_deck"
  fill_in "deck_name", with: name
  click_button "add_deck_btn"
end
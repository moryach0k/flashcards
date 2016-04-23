class AddCurrentDeckToDecks < ActiveRecord::Migration
  def change
    add_column :decks, :current_deck, :boolean
  end
end

class RemoveCurrentDeckFromDecksAndAddCurrentDeckToUsers < ActiveRecord::Migration
  def change
    remove_column :decks, :current_deck
    add_column :users, :current_deck, :integer
  end
end

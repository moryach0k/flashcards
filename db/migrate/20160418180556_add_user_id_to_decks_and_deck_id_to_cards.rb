class AddUserIdToDecksAndDeckIdToCards < ActiveRecord::Migration
  def change
    add_column :decks, :user_id, :integer
    add_column :cards, :deck_id, :integer
  end
end

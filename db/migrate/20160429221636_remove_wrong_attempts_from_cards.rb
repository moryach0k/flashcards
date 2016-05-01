class RemoveWrongAttemptsFromCards < ActiveRecord::Migration
  def change
    remove_column :cards, :wrong_attempts
  end
end

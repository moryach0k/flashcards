class AddIntervalAndEfToCards < ActiveRecord::Migration
  def change
    add_column :cards, :interval, :integer, default: 0
    add_column :cards, :ef, :float, default: 2.5
  end
end

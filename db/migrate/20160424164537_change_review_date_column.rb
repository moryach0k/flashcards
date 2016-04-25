class ChangeReviewDateColumn < ActiveRecord::Migration
  def change
    change_column :cards, :review_date, :timestamp
  end
end

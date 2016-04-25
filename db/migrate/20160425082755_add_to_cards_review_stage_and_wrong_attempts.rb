class AddToCardsReviewStageAndWrongAttempts < ActiveRecord::Migration
  def change
    add_column :cards, :review_stage, :integer
    add_column :cards, :wrong_attempts, :integer
  end
end

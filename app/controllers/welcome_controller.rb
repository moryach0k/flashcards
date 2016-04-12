class WelcomeController < ApplicationController
  def index
    @user = current_user
    @card = @user.cards.needed_to_review.sample
  end
end

class WelcomeController < ApplicationController
  def index
    @user = current_user
    unless @user.nil?
      @card = @user.cards.needed_to_review.sample
    end
  end
end

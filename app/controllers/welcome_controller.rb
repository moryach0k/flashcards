class WelcomeController < ApplicationController
  def index
    unless current_user.nil?
      @card = current_user.cards.needed_to_review.sample
    end
  end
end

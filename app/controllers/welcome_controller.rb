class WelcomeController < ApplicationController
  def index
    unless current_user.nil?
      if current_user.current_deck.nil?
        @card = current_user.cards.needed_to_review.sample
      else
        @card = current_user.decks.find(current_user.current_deck).cards.needed_to_review.sample
      end
    end
  end
end

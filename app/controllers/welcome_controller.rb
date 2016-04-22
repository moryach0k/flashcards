class WelcomeController < ApplicationController
  def index
    unless current_user.nil?
      unless current_user.decks.current_deck[0].nil?
        @card = current_user.decks.current_deck[0].cards.needed_to_review.sample
      else
        @card = current_user.cards.needed_to_review.sample
      end
    end
  end
end

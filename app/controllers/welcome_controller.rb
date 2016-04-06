class WelcomeController < ApplicationController
  def index
    @card = Card.needed_to_review.sample
  end
end

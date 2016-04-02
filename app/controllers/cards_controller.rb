class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end
end

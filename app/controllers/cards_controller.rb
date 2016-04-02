class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.review_date = Time.now.to_date + 3

    if @card.save
      redirect_to cards_path
    else
      render "new"
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
  end

  private
  def card_params
    params.require(:card).permit(:original_text, :translated_text)
  end
end

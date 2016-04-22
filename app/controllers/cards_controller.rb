class CardsController < ApplicationController
  def index
    @cards = current_user.cards.all
  end

  def new
    @card = current_user.decks.find(params[:deck_id]).cards.new
  end

  def create
    @card = Card.create(card_params.merge(user: current_user, deck: Deck.find(params[:deck_id])))
    @card.increase_review_date

    if @card.save
      redirect_to deck_path(params[:deck_id]), notice: 'Card was successfully created.'
    else
      render "new"
    end
  end

  def edit
    @card = Card.find(params[:id])
  end

  def update
    @card = Card.find(params[:id])

    if @card.update(card_params)
      redirect_to cards_path, notice: 'Card was successfully edited.'
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    deck = @card.deck
    @card.destroy

    redirect_to deck_path(deck)
  end

  def compare_texts
    @card = Card.find(params[:id])
    if @card.correctly_translated(params[:user_original_text])
      flash[:notice] = "Правильно!"
      @card.save
    else
      flash[:notice] = "Неправильно!"
    end
    redirect_to root_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image)
  end
end

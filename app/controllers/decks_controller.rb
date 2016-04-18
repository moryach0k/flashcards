class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def new
    @user = current_user
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.create(deck_params)

    if @deck.save
      redirect_to decks_path, notice: 'Deck was successfully created.'
    else
      render "new"
    end
  end

  def edit
    @deck = Deck.find(params[:id])
  end

  def update
    @deck = Deck.find(params[:id])

    if @deck.update(deck_params)
      redirect_to decks_path, notice: 'Deck was successfully edited.'
    else
      render 'edit'
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.destroy

    redirect_to decks_path
  end

  def current_deck
    @current_deck = Deck.find(params[:id])
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end

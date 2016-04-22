class DecksController < ApplicationController
  def index
    @decks = current_user.decks.all
  end

  def show
    @deck = Deck.find(params[:id])
  end

  def new
    @user = current_user
    @deck = Deck.new
  end

  def create
    @deck = current_user.decks.create(deck_params.merge(current_deck: false))

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

  def set_current
    deck = Deck.where("current_deck = ?", true)
    deck[0].current_deck = false
    deck[0].save
    @deck = Deck.find(params[:id])
    @deck.set_current
    @deck.save
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end

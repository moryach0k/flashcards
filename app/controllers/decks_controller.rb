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
    @deck = current_user.decks.create(deck_params)

    if @deck.save
      redirect_to decks_path, notice: t("deck.created")
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
      redirect_to decks_path, notice: t("deck.edited")
    else
      render 'edit'
    end
  end

  def destroy
    @deck = Deck.find(params[:id])
    @deck.cards.destroy_all
    @deck.destroy

    redirect_to decks_path
  end

  def set_current
    current_user.update(current_deck: params[:id])
    redirect_to decks_path
  end

  private

  def deck_params
    params.require(:deck).permit(:name)
  end
end

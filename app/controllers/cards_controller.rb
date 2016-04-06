class CardsController < ApplicationController
  def index
    @cards = Card.all
  end

  def new
    @card = Card.new
  end

  def create
    @card = Card.new(card_params)
    @card.increase_review_date

    if @card.save
      redirect_to cards_path
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
      redirect_to cards_path
    else
      render 'edit'
    end
  end

  def destroy
    @card = Card.find(params[:id])
    @card.destroy

    redirect_to cards_path
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
    params.require(:card).permit(:original_text, :translated_text)
  end
end

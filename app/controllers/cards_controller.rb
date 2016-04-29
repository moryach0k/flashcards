class CardsController < ApplicationController
  def index
    @cards = current_user.cards.all
  end

  def new
    @card = current_user.decks.find(params[:deck_id]).cards.new
  end

  def create
    @card = Card.create!(card_params.merge(user: current_user, deck: Deck.find(params[:deck_id]), review_date: Time.current, review_stage: 1))

    if @card.save
      redirect_to deck_path(params[:deck_id]), notice: t("card.created")
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
      redirect_to decks_path, notice: t("card.edited")
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
    @card.check_translation(params[:user_original_text], params[:quality_timer])
    @card.save
    if @card.correctly_translated?
      flash[:notice] = t("notice.right")
    else
      flash[:notice] = t("notice.wrong")
    end
    redirect_to root_path
  end

  private

  def card_params
    params.require(:card).permit(:original_text, :translated_text, :image, :review_date)
  end
end

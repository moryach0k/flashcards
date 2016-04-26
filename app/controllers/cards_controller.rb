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
    if @card.correctly_translated(params[:user_original_text])[:typos_count] == 0
      flash[:notice] = t("notice.right")
      @card.save
    elsif @card.correctly_translated(params[:user_original_text])[:typos_count] == 1
      flash[:notice] = t("notice.right_with_typo_part_1") + @card.original_text + t("notice.right_with_typo_part_1") + params[:user_original_text]
      @card.save
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

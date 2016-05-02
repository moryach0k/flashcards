class WelcomeController < ApplicationController
  def index
    unless current_user.nil?
      @card = if current_user.current_deck.nil?
                current_user.cards.needed_to_review.sample
              else
                current_user.decks.find(current_user.current_deck).cards.needed_to_review.sample
              end
      respond_to do |format|
        format.html
        format.js
      end
    end
  end

  def compare_texts
    @card = Card.find(params[:id])
    @card.check_translation(params[:user_original_text], params[:quality_timer])
    if @card.correctly_translated?(params[:user_original_text])
      flash[:notice] = t("notice.right")
    else
      flash[:notice] = t("notice.wrong")
    end
    redirect_to root_path
  end
end

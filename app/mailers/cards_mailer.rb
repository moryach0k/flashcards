class CardsMailer < ApplicationMailer
  default from: 'notifications@flashcards.com'
  def pending_cards_notification(user)
    @user = user
    mail to: @user.email, subject: 'You have pending cards!'
  end
end

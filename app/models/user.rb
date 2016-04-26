class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :cards
  has_many :decks

  def notify_about_pending_cards
    User.all.each do |user|
      unless user.cards.needed_to_review.nil?
        CardsMailer.pending_cards_notification(user).deliver_now
    end
  end
end

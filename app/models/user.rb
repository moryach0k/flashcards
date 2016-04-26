class User < ActiveRecord::Base
  authenticates_with_sorcery!

  validates :password, length: { minimum: 3 }, if: -> { new_record? || changes[:crypted_password] }
  validates :password, confirmation: true, if: -> { new_record? || changes[:crypted_password] }
  validates :password_confirmation, presence: true, if: -> { new_record? || changes[:crypted_password] }

  validates :email, uniqueness: true

  has_many :cards
  has_many :decks


  def notify_about_pending_cards
    User.joins(:cards).where('cards.review_date <= ?', Time.current) do |user|
      CardsMailer.pending_cards_notification(user).deliver_now
    end
  end
end

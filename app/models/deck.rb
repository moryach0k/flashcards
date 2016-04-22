class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :user, presence: true

  scope :current_deck, -> { where("current_deck = ?", true)}

  def set_current
    self.current_deck = true
  end
end

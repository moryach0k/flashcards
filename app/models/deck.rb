class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :user, presence: true

  def current_deck?(id)
    if self.id == id
      return true
    end
  end
end

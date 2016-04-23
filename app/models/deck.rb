class Deck < ActiveRecord::Base
  has_many :cards
  belongs_to :user

  validates :user, presence: true

  after_destroy :set_to_nil_current_deck

  protected
  def set_to_nil_current_deck
    if self.id == self.user.current_deck
      self.user.update(current_deck: nil)
    end
  end
end

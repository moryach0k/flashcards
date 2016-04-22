class Deck < ActiveRecord::Base
  has_many :cards

  validates :user, presence: true
end

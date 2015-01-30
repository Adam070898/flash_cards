class Deck < ActiveRecord::Base
  has_many :rounds
  has_many :cards
  def cardcount
    self.cards.count
  end
end

class Room < ApplicationRecord
  validates :game, presence: true
  validates :status, presence: true
  validates :password, presence: true

  has_many :players
  has_one :game
end

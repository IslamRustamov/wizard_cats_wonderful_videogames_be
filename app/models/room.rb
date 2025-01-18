class Room < ApplicationRecord
  validates :game_type, presence: true
  validates :status, presence: true
  validates :password, presence: true

  has_many :players
end

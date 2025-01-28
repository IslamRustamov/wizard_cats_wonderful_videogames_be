class Game < ApplicationRecord
  validates :name, presence: true
  validates :min_players, presence: true
  validates :max_players, presence: true
end

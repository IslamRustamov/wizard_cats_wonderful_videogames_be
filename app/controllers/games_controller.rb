class GamesController < ApplicationController
  def index
    render json: { games: Game.all.map { |game| game.name } }
  end
end

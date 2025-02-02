class GamesController < ApplicationController
  def index
    render json: { games: Game.all.map { |game| { name: game.name, min_players: game.min_players } } }
  end
end

class PlayersController < ApplicationController
  skip_before_action :verify_authenticity_token

  def index
    render json: { "eskere": "swag" }
  end

  def create
    @player = Player.new()

    @player.save

    render json: { player_id: @player.id }
  end
end

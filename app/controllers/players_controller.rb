class PlayersController < ApplicationController
  def index
    render json: { "eskere": "swag" }
  end
end

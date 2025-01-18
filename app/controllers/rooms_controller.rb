class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @room = Room.new()

    @room.game_type = params[:game_type]
    @room.status = "active"
    @room.password = (0...8).map { (65 + rand(26)).chr }.join

    @room.save

    @room.players.create()

    render json: { room_id: @room.id, player_id: @room.players.first.id, password: @room.password }
  end
end

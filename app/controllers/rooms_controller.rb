class RoomsController < ApplicationController
  skip_before_action :verify_authenticity_token
  def create
    @player = find_player_by_id

    @room = Room.new()

    @room.game = find_game_by_name
    @room.status = "active"
    @room.password = (0...8).map { (65 + rand(26)).chr }.join

    @room.save

    @room.players << @player

    render json: { room_id: @room.id, player_id: @room.players.first.id, password: @room.password }
  end

  def join
    @player = find_player_by_id

    @room = find_room_by_password

    if @room.players.count == @room.game.max_players
      raise ActiveRecord::ActiveRecordError
    end

    # TODO: I need to somehow make rooms inactive
    if @room.status == "inactive"
      raise ActiveRecord::ActiveRecordError
    end

    @room.players << @player

    render json: { room_id: @room.id, player_id: @room.players.second.id, password: @room.password }
  end

  private
    def find_player_by_id
      if player = Player.find_by(id: params[:player_id])
        player
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def find_game_by_name
      if game = Game.find_by(name: params[:game_name])
        game
      else
        raise ActiveRecord::RecordNotFound
      end
    end

    def find_room_by_password
      if room = Room.find_by(password: params[:password])
        room
      else
        raise ActiveRecord::RecordNotFound
      end
    end
end

class RoomChannel < ApplicationCable::Channel
  def subscribed
    @room = find_room

    if !current_player
      raise ActiveRecord::RecordNotFound
    end

    stream_for @room
  end

  def receive(data)
    puts data
    puts data["eskere"]
  end

  private
  def find_room
    if room = Room.find_by(id: params[:room_id])
      room
    else
      raise ActiveRecord::RecordNotFound
    end
  end
end

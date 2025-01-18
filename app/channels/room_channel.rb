class RoomChannel < ApplicationCable::Channel
  def subscribed
    puts "HE HAS CONNECTED"
    puts params[:room_id]
    puts current_player
    stream_from "room_#{params[:room_id]}"
  end

  def unsubscribed
    puts "he unsubscribed"
  end

  def receive(data)
    puts data["eskere"]
  end
end

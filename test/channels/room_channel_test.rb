require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    stub_connection(current_player: Player.first)

    subscribe room_id: 15

    assert subscription.confirmed?
  end
end

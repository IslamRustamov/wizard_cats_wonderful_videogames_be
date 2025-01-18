require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  test "subscribes" do
    subscribe room_id: 15

    assert subscription.confirmed?
  end
end

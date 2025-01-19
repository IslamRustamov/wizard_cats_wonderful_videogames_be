require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  setup do
    @player = Player.new
    @player.save

    @room = Room.new

    @room.game_type = "knucklebones"
    @room.status = "active"
    @room.password = (0...8).map { (65 + rand(26)).chr }.join

    @room.save
  end

  teardown do
    @player.delete
    @room.delete
  end

  test "should subscribe with valid player and valid room id" do
    stub_connection(current_player: @player)

    subscribe room_id: @room.id

    assert subscription.confirmed?
  end

  test "should has stream for valid user and valid room id" do
    stub_connection(current_player: @player)

    subscribe room_id: @room.id

    assert_has_stream_for @room
  end

  test "should accept message" do
    stub_connection(current_player: @player)

    subscribe room_id: @room.id

    assert_broadcast_on(RoomChannel.broadcasting_for(@room), { command: "message", data: { eskere: "yes" } }) do
      RoomChannel.broadcast_to @room, { command: "message", data: { eskere: "yes" } }
    end
  end

  test "should unsubscribe" do
    stub_connection(current_player: @player)

    subscribe room_id: @room.id

    unsubscribe

    assert_no_streams
  end

  test "should throw an error if invalid room id passed" do
    stub_connection(current_player: @player)

    assert_raises(ActiveRecord::RecordNotFound) do
      subscribe room_id: 15
    end
  end

  test "should throw an error if no player" do
    assert_raises(ActiveRecord::RecordNotFound) do
      subscribe room_id: 15
    end
  end
end

require "test_helper"

class RoomChannelTest < ActionCable::Channel::TestCase
  setup do
    @player_one = Player.new
    @player_one.save

    @room = Room.new

    @room.game_type = "knucklebones"
    @room.status = "active"
    @room.password = (0...8).map { (65 + rand(26)).chr }.join

    @room.save
  end

  teardown do
    @player_one.delete
    @room.delete
  end

  test "should subscribe with valid player and valid room id" do
    stub_connection(current_player: @player_one)

    subscribe room_id: @room.id

    assert subscription.confirmed?
  end

  test "should has stream for valid user and valid room id" do
    stub_connection(current_player: @player_one)

    subscribe room_id: @room.id

    assert_has_stream_for @room
  end

  test "should send message" do
    stub_connection(current_player: @player_one)

    subscribe room_id: @room.id

    assert_broadcast_on(RoomChannel.broadcasting_for(@room), { command: "message", data: { eskere: "yes" } }) do
      RoomChannel.broadcast_to @room, { command: "message", data: { eskere: "yes" } }
    end
  end

  test "should broadcast game step" do
    stub_connection(current_player: @player_one)

    subscribe room_id: @room.id

    assert_broadcast_on(RoomChannel.broadcasting_for(@room), { command: "message", type: "game_step", data: { some: "data" } }) do
      subscription.receive({ command: "message", type: "game_step", data: { some: "data" } })
    end
  end

  test "should set winner" do
    stub_connection(current_player: @player_one)

    subscribe room_id: @room.id

    assert_broadcast_on(RoomChannel.broadcasting_for(@room), { command: "message", type: "game_end", winner_id: @player_one.id }) do
      subscription.receive({ command: "message", type: "game_end", winner_id: @player_one.id })
    end

    @room.reload

    assert_equal @room.winner_id, @player_one.id
    assert_equal @room.status, "inactive"
  end

  test "should unsubscribe" do
    stub_connection(current_player: @player_one)

    subscribe room_id: @room.id

    unsubscribe

    assert_no_streams
  end

  test "should throw an error if invalid room id passed" do
    stub_connection(current_player: @player_one)

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

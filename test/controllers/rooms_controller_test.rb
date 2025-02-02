require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game = Game.new
    @game.name = "knucklebones"
    @game.min_players = 2
    @game.max_players = 2

    @game.save
  end

  teardown do
    @game.delete
  end

  test "should create new room with specified game type" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end

    assert_equal "knucklebones", Room.first.game.name
  end

  test "should return new room password" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end

    assert_not_empty JSON.parse(@response.body)["password"]
  end

  test "should return new room id" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end

    assert_not_nil JSON.parse(@response.body)["room_id"]
  end

  test "should return new room players" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end

    assert_not_nil JSON.parse(@response.body)["player_id"]
  end

  test "should be able to join new room by password" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end

    room_password = JSON.parse(@response.body)["password"]

    first_player_id = JSON.parse(@response.body)["player_id"]

    assert_difference("Player.count") do
      get rooms_url + "/" + room_password
    end

    second_player_id = JSON.parse(@response.body)["player_id"]

    assert_not_equal first_player_id, second_player_id

    assert_equal Room.first.players.count, 2
  end

  test "should throw an error if too many players trying to join" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end

    room_password = JSON.parse(@response.body)["password"]

    assert_difference("Player.count") do
      get rooms_url + "/" + room_password
    end

    assert_raises(ActiveRecord::ActiveRecordError) do
      get rooms_url + "/" + room_password
    end
  end

  test "should create new player on room creation" do
    assert_difference("Player.count") do
      post rooms_url, params: { game_name: "knucklebones" }
    end
  end
end

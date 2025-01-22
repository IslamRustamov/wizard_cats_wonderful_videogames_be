require "test_helper"

class RoomsControllerTest < ActionDispatch::IntegrationTest
  test "should create new room with specified game type" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end

    assert_equal "knucklebones", Room.first.game_type
  end

  test "should return new room password" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end

    assert_not_empty JSON.parse(@response.body)["password"]
  end

  test "should return new room id" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end

    assert_not_nil JSON.parse(@response.body)["room_id"]
  end

  test "should return new room players" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end

    assert_not_nil JSON.parse(@response.body)["player_id"]
  end

  test "should be able to join new room by password" do
    assert_difference("Room.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end

    room_password = JSON.parse(@response.body)["password"]

    first_player_id = JSON.parse(@response.body)["player_id"]

    assert_difference("Player.count") do
      post rooms_url + "/" + room_password
    end

    second_player_id = JSON.parse(@response.body)["player_id"]

    assert_not_equal first_player_id, second_player_id

    assert_equal Room.first.players.count, 2
  end

  test "should create new player on room creation" do
    assert_difference("Player.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end
  end
end

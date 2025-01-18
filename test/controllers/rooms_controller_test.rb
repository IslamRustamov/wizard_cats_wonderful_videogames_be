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

  test "should create new player on room creation" do
    assert_difference("Player.count") do
      post rooms_url, params: { game_type: "knucklebones" }
    end
  end
end

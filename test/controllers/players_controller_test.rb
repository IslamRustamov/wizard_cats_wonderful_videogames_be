require "test_helper"

class PlayersControllerTest < ActionDispatch::IntegrationTest
  test "should create new player" do
    post players_url

    assert_not_nil JSON.parse(@response.body)["player_id"]
  end
end

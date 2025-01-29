require "test_helper"

class GamesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @game_one = Game.new
    @game_one.name = "knucklebones"
    @game_one.min_players = 2
    @game_one.max_players = 2
    @game_one.save

    @game_two = Game.new
    @game_two.name = "fortnite"
    @game_two.min_players = 2
    @game_two.max_players = 2
    @game_two.save
  end

  teardown do
    @game_one.delete
    @game_two.delete
  end

  test "should return all games names" do
    get games_url

    assert_equal JSON.parse(@response.body)["games"].count, 2
    assert JSON.parse(@response.body)["games"].include? @game_one.name
    assert JSON.parse(@response.body)["games"].include? @game_two.name
  end
end

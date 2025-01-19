require "test_helper"

class ApplicationCable::ConnectionTest < ActionCable::Connection::TestCase
  setup do
    @player = Player.new
    @player.save
  end

  teardown do
    @player.delete
  end

  test "should connect to a websocket with correct player id" do
    connect params: { player_id: @player.id }

    assert_equal connection.current_player.id, @player.id
  end

  test "should reject connection without params" do
    assert_reject_connection { connect }
  end
end

require 'test_helper'

class TradesControllerTest < ActionController::TestCase
  setup do
    create_users
    create_teams
    create_players
    create_trades
  end

  teardown do
    destroy_trades
    destroy_players
    destroy_teams
    destroy_users
  end
  should "list all open trades on an index page" do
    get :index
    assert_response :success
    assert_not_nil assigns(:open_trades)
    assert_not_nil assigns(:xbox_trades)
    assert_not_nil assigns(:playstation_trades)
  end
end

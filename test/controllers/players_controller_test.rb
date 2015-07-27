require 'test_helper'

class PlayersControllerTest < ActionController::TestCase
  setup do
    create_teams
    create_players
  end

  teardown do
    destroy_players
    destroy_teams
  end

  should "should get show" do
    get :show, id: @giroux.id
    assert_response :success
    assert_not_nil assigns(:player)
    assert_not_nil assigns(:team)
  end

  should "respond with a 404 if a team is not found" do
    get :show, id: "wrong"
    assert_response :missing
  end

end

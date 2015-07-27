require 'test_helper'

class TeamsControllerTest < ActionController::TestCase
  setup do
    create_teams
    create_players
  end

  teardown do
    destroy_players
    destroy_teams
  end

  should "have an index page with all of the teams" do
    get :index
    assert_response :success
    assert_not_nil assigns(:teams)
  end

  should "have a show page that also includes all of the players on the team" do
    get :show, id: @flyers.id
    assert_response :success
    assert_not_nil assigns(:team)
    assert_not_nil assigns(:players)
  end

  should "respond with a 404 if a team is not found" do
    get :show, id: "wrong"
    assert_response :missing
  end

end

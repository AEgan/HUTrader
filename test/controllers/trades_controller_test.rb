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

  should "be redirected home if nobody is logged in and you go to the new trade page" do
    get :new
    assert_not_authorized
  end

  should "be redirected home if nobody is logged in an a create trade is attempted" do
    post :create, trade: { player_id: @giroux.id }
    assert_not_authorized
  end

  should "render the new page if logged in" do
    session[:user_id] = @alex.id
    get :new
    assert_not_nil assigns(:trade)
    assert_not_nil assigns(:teams)
  end

  should "not successfully create a player without a player_id" do
    session[:user_id] = @alex.id
    assert_no_difference("Trade.count") do
      post :create, trade: { player_id: nil }
    end
    assert_template :new
  end

  should "successfully create a player with a valid player_id" do
    session[:user_id] = @alex.id
    assert_difference("Trade.count", 1) do
      post :create, trade: { player_id: @tavares.id }
    end
    assert_redirected_to trade_path(assigns(:trade))
    assert_equal "Trade for #{@tavares.proper_name} has been posted.", flash[:notice]
  end

  context "with trade offers" do
    setup do
      create_offers
    end
    teardown do
      destroy_offers
    end

    should "successfully get trade information" do
      get :show, id: @alex_giroux_trade.id
      assert_response :success
      assert_not_nil assigns(:trade)
      assert_not_nil assigns(:user)
      assert_not_nil assigns(:player)
      assert_not_nil assigns(:offers)
    end

    should "include the trade partners information if available" do
      get :show, id: @ryan_voracek_trade.id
      assert_response :success
      assert_not_nil assigns(:partner)
    end
  end

  should "respond with a 404 if a trade is not found" do
    get :show, id: -1
    assert_response :missing
  end

  should "not be able to cancel a trade if not logged in" do
    post :cancel, id: @alex_giroux_trade.id
    assert_not_authorized
  end

  should "not be able to cancel a trade if not logged in as the user who created the trade" do
    session[:user_id] = @ryan.id
    post :cancel, id: @alex_giroux_trade.id
    assert_not_authorized
  end

  should "be able to cancel a trade if logged in as the user who created the trade" do
    session[:user_id] = @alex.id
    post :cancel, id: @alex_giroux_trade.id
    assert_redirected_to assigns(:trade)
    assert_equal "Trade has been closed.", flash[:notice]
    @alex_giroux_trade.reload
    assert @alex_giroux_trade.status == Trade::STATUSES['closed']
  end

  should "not be able to cancel a trade if it's already been completed" do
    session[:user_id] = @matt.id
    post :cancel, id: @matt_mcdonagh_trade.id
    assert_not_authorized
  end
end

require 'test_helper'

class OffersControllerTest < ActionController::TestCase
  setup do
    create_users
    create_teams
    create_players
    create_trades
    create_offers
  end

  teardown do
    destroy_offers
    destroy_trades
    destroy_players
    destroy_teams
    destroy_users
  end

  should "get the new offer page if logged in and can offer a trade" do
    session[:user_id] = @alex.id
    get :new, trade_id: @mike_giroux_trade.id
    assert_response :success
    assert_not_nil assigns(@offer)
    assert_not_nil assigns(@trade)
    assert_not_nil assigns(@user)
    assert_not_nil assigns(@player)
    assert_not_nil assigns(@teams)
  end

  should "get a 404 if it can't find the trade" do
    session[:user_id] = @alex.id
    get :new, trade_id: -1
    assert_response :missing
  end

  should "be redirected home if not logged in but trying to offer a trade" do
    get :new, trade_id: @mike_giroux_trade.id
    assert_not_authorized
  end

  # TODO redirect to edit offer page, once edit/update implemented
  should "be redirected and alerted if you've already offered a trade" do
    session[:user_id] = @alex.id
    get :new, trade_id: @matt_mcdonagh_trade.id
    assert_offering_repeat_trade
  end

  should "be redirected home and alerted if you try to offer a trade to your own team" do
    session[:user_id] = @matt.id
    get :new, trade_id: @matt_mcdonagh_trade.id
    assert_offering_for_own_trade
  end

  should "not successfully create an offer if not logged in" do
    post :create, trade_id: @matt_mcdonagh_trade.id, offer: {}
    assert_not_authorized
  end

  should "be redirected and alerted if already created an offer for a trade" do
    session[:user_id] = @alex.id
    post :create, trade_id: @matt_mcdonagh_trade, offer: {}
    assert_offering_repeat_trade
  end

  should "be redirected an dalerted if already posting an offer to your own trade" do
    session[:user_id] = @matt.id
    get :new, trade_id: @matt_mcdonagh_trade.id
    assert_offering_for_own_trade
  end

  should "render the new page again if offer fails validations" do
    session[:user_id] = @alex.id
    assert_no_difference("Offer.count") do
      post :create, trade_id: @mike_giroux_trade.id, offer: { coins: -1000 }
    end
    assert_template :new
  end

  should "successfully create an offer if validations pass" do
    session[:user_id] = @alex.id
    assert_difference("Offer.count") do
      post :create, trade_id: @mike_giroux_trade.id, offer: { coins: 10000 }
    end
    assert_response :redirect
    assert_equal "Your offer has been posted", flash[:notice]
  end

  should "successfully create offer_players with nested attributes" do
    session[:user_id] = @alex.id
    assert_difference("OfferPlayer.count", 2) do
      post :create, trade_id: @mike_giroux_trade.id, offer: { coins: 10000,
        offer_players_attributes: {
          '0'=>{'player_id'=>@giroux.id},
          '1'=> {'player_id'=>@tavares.id}
          }
        }
    end
    assert_response :redirect
    assert_equal "Your offer has been posted", flash[:notice]
  end

  should "not create the offer if the offer player validations fail" do
    session[:user_id] = @alex.id
    assert_no_difference("Offer.count") do
      post :create, trade_id: @mike_giroux_trade.id, offer: { coins: 10000,
        offer_players_attributes: {
          '0'=>{'player_id'=>-10}
          }
        }
    end
    assert_template :new
  end

  private
  def assert_offering_for_own_trade
    assert_response :redirect
    assert_equal "You can't make an offer to your own trade.", flash[:warning]
  end

  def assert_offering_repeat_trade
    assert_response :redirect
    assert_equal "You have already placed a trade offer.", flash[:warning]
  end
end

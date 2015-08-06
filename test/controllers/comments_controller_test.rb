require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
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

  should "not get the new page if not logged in" do
    get :new, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id
    assert_not_authorized
  end

  should "not get the new page if not part of the offer" do
    session[:user_id] = @ryan.id
    get :new, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id
    assert_not_authorized("You must be involved in the offer to post a comment.")
  end

  should "give a 404 if the trade's id and the offer's trade_id are not equal" do
    session[:user_id] = @alex.id
    get :new, trade_id: @alex_giroux_trade.id, offer_id: @john_offer_for_ryan_voracek.id
    assert_response :missing
  end

  should "get the new page if involved with the offer" do
    session[:user_id] = @alex.id
    get :new, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id
    assert_response :success
  end

  should "not create if not logged in" do
    assert_no_difference("Comment.count") do
      post :create, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id,
        comment: { body: "New Comment" }
    end
    assert_not_authorized
  end

  should "not create if not involved in the trade" do
    session[:user_id] = @ryan.id
    assert_no_difference("Comment.count") do
      post :create, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id,
        comment: { body: "New Comment" }
    end
    assert_not_authorized("You must be involved in the offer to post a comment.")
  end

  should "create successfully if not involved in the trade" do
    session[:user_id] = @alex.id
    assert_difference("Comment.count", 1) do
      post :create, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id, comment: { body: "New Comment" }
    end
    assert_redirected_to trade_offer_path(@alex_giroux_trade, @mike_offer_for_alex_giroux)
    assert_equal "Comment successfully posted.", flash[:notice]
  end

  should "render the new template if creating the comment fails" do
    session[:user_id] = @alex.id
    assert_no_difference("Comment.count") do
      post :create, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id, comment: { body: "" }
    end
    assert_template :new
  end

  should "give a 404 if trying to create a comment but the trade's id doesn't match the offer's trade_id" do
    session[:user_id] = @alex.id
    assert_no_difference("Comment.count") do
      post :create, trade_id: @alex_giroux_trade.id, offer_id: @john_offer_for_ryan_voracek.id, comment: { body: "good" }
    end
    assert_response :missing
  end

  context "with a set of comments" do
    setup do
      create_comments
    end

    teardown do
      destroy_comments
    end

    should "not get the edit page if not logged in" do
      get :edit, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id, id: @alex_comment_on_mike_offer.id
      assert_not_authorized
    end

    should "not get edit page if logged in with non-poster" do
      session[:user_id] = @mike.id
      get :edit, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id, id: @alex_comment_on_mike_offer.id
      assert_not_authorized
    end

    should "get edit page if logged in with correct user" do
      session[:user_id] = @alex.id
      get :edit, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id, id: @alex_comment_on_mike_offer.id
      assert_response :success
      assert_template :edit
    end

    should "not update if not logged in" do
      put :update, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id,
        id: @alex_comment_on_mike_offer.id, comment: { body: "Updated" }
      assert_not_authorized
    end

    should "not update if not logged in as comment poster" do
      session[:user_id] = @mike.id
      put :update, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id,
        id: @alex_comment_on_mike_offer.id, comment: { body: "Updated" }
      assert_not_authorized
    end

    should "be able to update your own comment" do
      session[:user_id] = @alex.id
      put :update, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id,
        id: @alex_comment_on_mike_offer.id, comment: { body: "Updated" }
      assert_redirected_to trade_offer_path(assigns(:trade), assigns(:offer))
      assert_equal "Comment successfully updated.", flash[:notice]
      @alex_comment_on_mike_offer.reload
      assert_equal "Updated", @alex_comment_on_mike_offer.body
    end

    should "render the edit page if validations fail" do
      session[:user_id] = @alex.id
      put :update, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id,
        id: @alex_comment_on_mike_offer.id, comment: { body: nil }
      assert_template :edit
    end

    should "respond with a 404 if the comment's offer_id is not the same os the offer's id" do
      session[:user_id] = @ryan.id
      get :edit, trade_id: @alex_giroux_trade.id, offer_id: @mike_offer_for_alex_giroux.id, id: @ryan_comment_on_john_offer.id
      assert_response :missing
    end
  end
end

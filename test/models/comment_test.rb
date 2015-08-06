require 'test_helper'

class CommentTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:user)
  should belong_to(:offer)

  # presence validations
  should validate_presence_of(:body)

  context "with a set of comments for testing" do
    setup do
      create_users
      create_teams
      create_players
      create_trades
      create_offers
      create_comments
    end

    teardown do
      destroy_comments
      destroy_offers
      destroy_trades
      destroy_players
      destroy_teams
      destroy_users
    end

    should "have a #trade method to get the offer's trade" do
      assert_equal @alex_giroux_trade, @alex_comment_on_mike_offer.trade
    end
    
    should "not be created without a valid offer" do
      no_offer = FactoryGirl.build(:comment, offer_id: -1, user: @alex)
      deny no_offer.valid?
    end

    should "not be created without a valid user" do
      no_user = FactoryGirl.build(:comment, offer: @alex_offer_for_mike_giroux, user_id: -1)
      deny no_user.valid?
    end

    should "not be able to comment if not involved in the trade or offer" do
      unrelated_comment = FactoryGirl.build(:comment, offer: @alex_offer_for_mike_giroux, user: @ryan)
      deny unrelated_comment.valid?
    end
  end
end

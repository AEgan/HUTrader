require 'test_helper'

class OfferTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:trade)
  should belong_to(:user)
  should have_and_belong_to_many(:players)

  # validations
  should validate_numericality_of(:coins).only_integer.is_greater_than_or_equal_to(0)

  context "with a set of offers for testing" do
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

    should "have working factories for testing" do
      assert_equal 4, Offer.all.length
    end

    should "have a scope to order the offers by the coin value" do
      assert_equal [15000, 5000, 0, 0], Offer.by_coins.map(&:coins)
    end

    should "not let an offer be created without a valid trade" do
      no_trade = FactoryGirl.build(:offer, trade: nil, user: @alex, coins: 3000)
      deny no_trade.valid?
    end

    should "not let an offer be created without a valid user" do
      no_user = FactoryGirl.build(:offer, trade: @alex_giroux_trade, user: nil)
      deny no_user.valid?
    end

    should "not let an offer be created if it is a repeat (same user and trade)" do
      repeat = FactoryGirl.build(:offer, trade: @alex_giroux_trade, user: @john)
      deny repeat.valid?
    end

    should "be able to add players to an offer using the join table" do
      @john_offer_for_alex_giroux.players << @voracek
      @john_offer_for_alex_giroux.players << @mcdonagh
      assert_equal 2, @john_offer_for_alex_giroux.players.length
    end
  end
end

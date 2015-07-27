require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:user)
  should belong_to(:partner).class_name("User")
  should belong_to(:player)

  # validations
  should validate_numericality_of(:user_rating).only_integer
  should validate_numericality_of(:partner_rating).only_integer

  # values for status
  should allow_value("Open").for(:status)
  should allow_value("Partner Found").for(:status)
  should allow_value("Awaiting Ratings").for(:status)
  should allow_value("Complete").for(:status)
  should allow_value("Closed").for(:status)

  should_not allow_value("waiting").for(:status)
  should_not allow_value(nil).for(:status)
  should_not allow_value(1).for(:status)

  context "With a set of trades for testing" do
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

    should "have a scope to find all open trades" do
      assert_equal [@alex_giroux_trade, @john_tabares_trade].to_set, Trade.open.to_set
    end

    should "Have a scope to find all completed trades" do
      assert_equal [@matt_mcdonagh_trade, @mike_giroux_trade].to_set, Trade.complete.to_set
    end

    should "Not allow a trade to be created without a valid user" do
      no_user = FactoryGirl.build(:trade, user_id: -1, player: @giroux, partner: nil)
      deny no_user.valid?
    end

    should "Not allow a trade to be created without a valid player" do
      no_player = FactoryGirl.build(:trade, user: @alex, player_id: -1, partner: @john)
      deny no_player.valid?
    end
  end

end

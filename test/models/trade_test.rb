require 'test_helper'

class TradeTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:user)
  should belong_to(:partner).class_name("User")
  should belong_to(:player)
  should have_many(:offers)

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

    should "have a scope to sort trades in order of newest to oldest" do
      assert_equal [@john_tabares_trade, @mike_giroux_trade, @matt_mcdonagh_trade, @ryan_voracek_trade, @alex_giroux_trade], Trade.chronological
    end

    should "Not allow a trade to be created without a valid user" do
      no_user = FactoryGirl.build(:trade, user_id: -1, player: @giroux, partner: nil)
      deny no_user.valid?
    end

    should "Not allow a trade to be created without a valid player" do
      no_player = FactoryGirl.build(:trade, user: @alex, player_id: -1, partner: @john)
      deny no_player.valid?
    end

    context "with offers for trades" do
      setup do
        create_offers
      end
      teardown do
        destroy_offers
      end

      should "have a method to get the offer that has been accepted for the trade" do
        assert_equal @alex_offer_for_ryan_voracek, @ryan_voracek_trade.offer
        destroy_offers
      end

      should "return nil if a trade does not have a confirmed partner" do
        assert_nil @john_tabares_trade.offer
      end

      should "add an error if the partner_id is set but that user does not exist" do
        assert @alex_giroux_trade.valid?
        @alex_giroux_trade.partner_id = -1
        deny @alex_giroux_trade.valid?
      end

      should "add an error if the trade partner has not actually offered a trade" do
        assert @alex_giroux_trade.valid?
        @alex_giroux_trade.partner_id = @matt.id
        deny @alex_giroux_trade.valid?
      end
    end
  end

end

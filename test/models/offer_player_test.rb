require 'test_helper'

class OfferPlayerTest < ActiveSupport::TestCase
  should belong_to(:offer)
  should belong_to(:player)

  context "creating offer players for testing" do
    setup do
      create_users
      create_teams
      create_players
      create_trades
      create_offers
      create_offer_players
    end

    teardown do
      destroy_offer_players
      destroy_offers
      destroy_trades
      destroy_players
      destroy_teams
      destroy_users
    end

    should "not allow a fifth player on an offer" do
      fifth_offer = FactoryGirl.build(:offer_player, offer: @mike_offer_for_alex_giroux, player: @tavares)
      deny fifth_offer.valid?
    end

    should "not allow an offer player to be created without a valid player" do
      no_player = FactoryGirl.build(:offer_player, player: nil, offer: @mike_offer_for_alex_giroux)
      deny no_player.valid?
    end
  end
end

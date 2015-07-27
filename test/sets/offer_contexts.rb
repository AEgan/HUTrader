module Contexts
  module OfferContexts
    def create_offers
      @john_offer_for_alex_giroux = FactoryGirl.create(:offer, trade: @alex_giroux_trade, user: @john, coins: 5000)
      @alex_offer_for_ryan_voracek = FactoryGirl.create(:offer, trade: @ryan_voracek_trade, user: @alex, coins: 15000)
      @alex_offer_for_matt_mcdonagh = FactoryGirl.create(:offer, trade: @matt_mcdonagh_trade, user: @alex)
      @john_offer_for_mike_giroux = FactoryGirl.create(:offer, trade: @mike_giroux_trade, user: @john)
    end

    def destroy_offers
      @john_offer_for_alex_giroux.destroy
      @alex_offer_for_ryan_voracek.destroy
      @alex_offer_for_matt_mcdonagh.destroy
      @john_offer_for_mike_giroux.destroy
    end
  end
end

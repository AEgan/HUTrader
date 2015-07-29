module Contexts
  module OfferContexts
    def create_offers
      @john_offer_for_alex_giroux = FactoryGirl.create(:offer, trade: @alex_giroux_trade, user: @john, coins: 5000)
      @alex_offer_for_ryan_voracek = FactoryGirl.create(:offer, trade: @ryan_voracek_trade, user: @alex, coins: 15000)
      @alex_offer_for_matt_mcdonagh = FactoryGirl.create(:offer, trade: @matt_mcdonagh_trade, user: @alex)
      @john_offer_for_mike_giroux = FactoryGirl.create(:offer, trade: @mike_giroux_trade, user: @john)
      # set partner ids now that offers have been created
      @ryan_voracek_trade.partner_id = @alex.id
      @ryan_voracek_trade.save!
      @matt_mcdonagh_trade.partner_id = @alex.id
      @matt_mcdonagh_trade.save!
      @mike_giroux_trade.partner_id = @john.id
      @mike_giroux_trade.save!
    end

    def destroy_offers
      @john_offer_for_alex_giroux.destroy
      @alex_offer_for_ryan_voracek.destroy
      @alex_offer_for_matt_mcdonagh.destroy
      @john_offer_for_mike_giroux.destroy
    end
  end
end

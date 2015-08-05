module Contexts
  module OfferContexts
    def create_offeres
      @mike_offer_for_alex_giroux = FactoryGirl.create(:offer, trade: @alex_giroux_trade, user: @mike, coins: 5000)
      @alex_offer_for_mike_giroux = FactoryGirl.create(:offer, trade: @mike_giroux_trade, user: @alex, coins: 15000)
      @john_offer_for_ryan_voracek = FactoryGirl.create(:offer, trade: @ryan_voracek_trade, user: @john)
      @ryan_offer_for_matt_mcdonagh = FactoryGirl.create(:offer, trade: @matt_mcdonagh_trade, user: @ryan)

      # update trades
      @ryan_voracek_trade.partner_id = @john.id
      @ryan_voracek_trade.status = Trade::STATUSES['partnered']
      @ryan_voracek_trade.save!
      @matt_mcdonagh_trade.partner_id = @ryan.id
      @matt_mcdonagh_trade.status = Trade::STATUSES['complete']
      @matt_mcdonagh_trade.save!
      @mike_giroux_trade.partner_id = @alex.id
      @mike_giroux_trade.status = Trade::STATUSES['complete']
      @mike_giroux_trade.save!
    end

    def destroy_offers
      @mike_offer_for_alex_giroux.destroy
      @alex_offer_for_mike_giroux.destroy
      @john_offer_for_ryan_voracek.destroy
      @ryan_offer_for_matt_mcdonagh.destroy
    end
  end
end

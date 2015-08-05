module Contexts
  module TradeContexts
    def create_trades
      @alex_giroux_trade = FactoryGirl.create(:trade, user: @alex, player: @giroux, partner: nil)
      @ryan_voracek_trade = FactoryGirl.create(:trade, user: @ryan, player: @voracek, partner: nil)
      @matt_mcdonagh_trade = FactoryGirl.create(:trade, user: @matt, player: @mcdonagh, partner: nil, user_rating: 10, partner_rating: 10)
      @mike_giroux_trade = FactoryGirl.create(:trade, user: @mike, player: @giroux, partner: nil, user_rating: 10, partner_rating: 5)
      @john_tavares_trade = FactoryGirl.create(:trade, user: @john, player: @tavares, partner: nil)
    end

    def destroy_trades
      @alex_giroux_trade.destroy
      @ryan_voracek_trade.destroy
      @matt_mcdonagh_trade.destroy
      @mike_giroux_trade.destroy
      @john_tavares_trade.destroy
    end
  end
end

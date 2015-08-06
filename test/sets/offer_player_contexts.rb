module Contexts
  module OfferPlayerContexts
    def create_offer_players
      @alex_giroux_offer_one = FactoryGirl.create(:offer_player, offer: @mike_offer_for_alex_giroux, player: @mcdonagh)
      @alex_giroux_offer_two = FactoryGirl.create(:offer_player, offer: @mike_offer_for_alex_giroux, player: @tavares)
      @alex_giroux_offer_three = FactoryGirl.create(:offer_player, offer: @mike_offer_for_alex_giroux, player: @voracek)
      @alex_giroux_offer_four = FactoryGirl.create(:offer_player, offer: @mike_offer_for_alex_giroux, player: @mcdonagh)
    end

    def destroy_offer_players
      @alex_giroux_offer_one.destroy
      @alex_giroux_offer_two.destroy
      @alex_giroux_offer_three.destroy
      @alex_giroux_offer_four.destroy
    end
  end
end

class OfferPlayer < ActiveRecord::Base
  include Referenceable

  belongs_to :offer
  belongs_to :player

  # Only check the reference for player because our nested form for offers
  # will create the offer and offer players at the same time
  validate -> { reference_exists_in_system(Player) }
  validate :four_players_or_fewer_on_offer, on: :create

  private
  def four_players_or_fewer_on_offer
    if OfferPlayer.where(offer_id: offer_id).length > 3
      errors.add(:base, "only 4 players are allowed to be on an offer")
    end
  end
end

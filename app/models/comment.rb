class Comment < ActiveRecord::Base
  include Referenceable
  # relationships
  belongs_to :user
  belongs_to :offer

  delegate :trade, to: :offer

  validates_presence_of :body
  validate -> { reference_exists_in_system(User) }
  validate -> { reference_exists_in_system(Offer) }
  validate :user_related_to_offer

  private
  def user_related_to_offer
    if (user_id.nil?) || (offer.nil?) || (user_id != offer.user_id && user_id != trade.user_id)
      errors.add(:user_id, "not involved in this offer")
    end
  end

end

class Offer < ActiveRecord::Base
  # include for validations
  include Referenceable

  # relationships
  belongs_to :trade
  belongs_to :user

  # validations
  validates_numericality_of :coins, only_integer: true, greater_than_or_equal_to: 0
  validate -> { reference_exists_in_system("Trade") }
  validate -> { reference_exists_in_system("User") }
  validate :trade_is_not_a_repeat

  # scopes
  scope :by_coins, -> { order(coins: :desc) }

  private
  # makes sure the same user can't make multiple offers to the same trade
  def trade_is_not_a_repeat
    # see if the record has been created, and has an id assigned
    number_that_can_exist = self.id.nil? ? 0 : 1
    if Offer.where(user_id: self.user_id, trade_id: self.trade_id).length > number_that_can_exist
      errors.add(:base, "user has already made an offer for this trade")
      return false
    end
    true
  end
end

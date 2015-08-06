class Offer < ActiveRecord::Base
  # include for validations
  include Referenceable

  # relationships
  belongs_to :trade
  belongs_to :user
  has_many :offer_players
  has_many :players, through: :offer_players
  has_many :comments

  accepts_nested_attributes_for :offer_players,
    reject_if: lambda {|offer_player| offer_player["player_id"].blank? },
    allow_destroy: true

  # validations
  validates_numericality_of :coins, only_integer: true, greater_than_or_equal_to: 0
  validate -> { reference_exists_in_system(Trade) }
  validate -> { reference_exists_in_system(User) }
  validate :trade_is_not_a_repeat
  validate :trade_is_open
  validate :user_on_same_console

  # scopes
  scope :by_coins, -> { order(coins: :desc) }

  private
  # makes sure the same user can't make multiple offers to the same trade
  def trade_is_not_a_repeat
    # see if the record has been created, and has an id assigned
    number_that_can_exist = id.nil? ? 0 : 1
    if Offer.where(user_id: user_id, trade_id: trade_id).length > number_that_can_exist
      errors.add(:user_id, "user has already made an offer for this trade")
    end
  end

  # makes sure a trade is open to offers before creating an offer
  def trade_is_open
    unless trade && trade.status == Trade::STATUSES['open']
      errors.add(:trade_id, "Offers cannot be made unless the trade is open.")
    end
  end

  # makes sure only offers for the same console are valid
  def user_on_same_console
    if user.nil? || trade.nil? || user.console != trade.user.console
      errors.add(:trade_id, "Trade must be for the same console")
    end
  end
end

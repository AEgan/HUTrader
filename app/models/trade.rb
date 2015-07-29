class Trade < ActiveRecord::Base
  include Referenceable
  # relationships
  belongs_to :user
  belongs_to :partner, class_name: "User"
  belongs_to :player
  has_many :offers

  # validations
  validates_numericality_of :user_rating, only_integer: true, allow_nil: true
  validates_numericality_of :partner_rating, only_integer: true, allow_nil: true
  validate -> { reference_exists_in_system(User) }
  validate -> { reference_exists_in_system(Player) }
  validate :partner_and_offer_are_valid?, if: :partner_id_changed?

  # we could get pretty detailed with different statuses, but I figured we need
  # a way to determine trades without a confirmed partner, completed trades to
  # use to see ratings, and closed (canceled). The other two aren't as important
  # for people looking for trades, but are intended for people involved with the trade
  validates_inclusion_of :status, in: ["Open", "Partner Found", "Awaiting Ratings", "Complete", "Closed"]

  # scopes
  scope :open, -> { where(status: "Open") }
  scope :complete, -> { where(status: "Complete") }

  # gets the offer that has been accepted by using the partner_id and the trade's id
  def offer
    Offer.where(user_id: partner_id, trade_id: id).first
  end

  private
  def partner_and_offer_are_valid?
    if User.find_by_id(partner_id).nil? || offer.nil?
      errors.add(:base, "there is no valid trade offer and partner for this trade")
    end
  end
end

class Player < ActiveRecord::Base
  include Referenceable
  # relationships
  belongs_to :team
  has_many :trades, dependent: :destroy
  has_many :offer_players
  has_many :offers, through: :offer_players

  # validations
  validates_presence_of :first_name, :last_name
  validates_numericality_of :overall, only_integer: true, allow_blank: true
  validate -> { reference_exists_in_system(Team) }

  # scopes
  scope :alphabetical, -> { order(:last_name, :first_name) }
  scope :by_overall, -> { order(overall: :desc) }

  # get the player's name in LAST, FIRST format
  def name
    "#{last_name}, #{first_name}"
  end

  # get the player's name in FIRST LAST format
  def proper_name
    "#{first_name} #{last_name}"
  end
end

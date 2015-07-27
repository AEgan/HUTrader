class User < ActiveRecord::Base
  # using bcrypt's has_secure_password
  has_secure_password

  # relationships
  has_many :trades
  # need a better name for this...
  has_many :partnered_trades, foreign_key: :partner_id, class_name: 'Trade'

  # validations
  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :console, numericality: { only_integer: true, greater_than: 0, less_than: 3 }, presence: true
  # can play with this later, but will have this for now
  # allow nil if there are no trades
  validates :reputation, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 10, allow_blank: true }
  # I got this from prof h https://github.com/profh/BreadExpress_Phase_5_Starter/blob/master/app/models/customer.rb#L21
  # can update later
  validates_format_of :email, with: /\A[\w]([^@\s,;]+)@(([\w-]+\.)+(com|edu|org|net|gov|mil|biz|info))\z/i, message: "is not a valid format"
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :team_name, presence: true, uniqueness: { case_sensitive: false, scope: :console }

  # scopes
  scope :alphabetical, -> { order(:username) }
  scope :for_console, ->(csl) { where(console: csl) }
  scope :for_xbox, -> { where(console: 1) }
  scope :for_playstation, -> { where(console: 2) }
  # might be useful when reputation is implemented
  scope :reputation_above, ->(rep) { where("reputation > ?", rep) }

  # methods
  def xbox_user?
    self.console == 1
  end

  def playstation_user?
    self.console == 2
  end

  def console_name
    self.xbox_user? ? "Xbox One" : "Playstation 4"
  end
end

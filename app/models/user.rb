class User < ActiveRecord::Base
  # using bcrypt's has_secure_password
  has_secure_password
  
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
end

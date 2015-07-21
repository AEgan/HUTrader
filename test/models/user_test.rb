require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # has_secure_password test
  should have_secure_password
  
  # validation testing
  should validate_presence_of :username
  should validate_presence_of :email
  should validate_presence_of :team_name
  should validate_numericality_of :console
  should validate_numericality_of :reputation
  
  should validate_uniqueness_of(:email).case_insensitive
  
  # shoulda matchers to test email regex
  should allow_value("fred@fred.com").for(:email)
  should allow_value("fred@andrew.cmu.edu").for(:email)
  should allow_value("my_fred@fred.org").for(:email)
  should allow_value("fred123@fred.gov").for(:email)
  should allow_value("my.fred@fred.net").for(:email)
  
  should_not allow_value("fred").for(:email)
  should_not allow_value("fred@fred,com").for(:email)
  should_not allow_value("fred@fred.uk").for(:email)
  should_not allow_value("my fred@fred.com").for(:email)
  should_not allow_value("fred@fred.con").for(:email)
  
  # shoulda matchers to test numericality validations
  # console
  should allow_value(1).for(:console)
  should allow_value(2).for(:console)
  should_not allow_value(3).for(:console)
  should_not allow_value(0).for(:console)
  should_not allow_value(nil).for(:console)
  should_not allow_value(1.5).for(:console)
  # reputation
  should allow_value(1).for(:reputation)
  should allow_value(2).for(:reputation)
  should allow_value(1.5).for(:reputation)
  should allow_value(nil).for(:reputation)
  should_not allow_value(-1).for(:reputation)
  should_not allow_value(11).for(:reputation)
end

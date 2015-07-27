require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # has_secure_password test
  should have_secure_password

  # relationship testing
  should have_many(:trades)
  should have_many(:partnered_trades).with_foreign_key(:partner_id).class_name('Trade')
  should have_many(:offers)

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

  context "With a set of users for testing" do
    setup do
      create_users
    end

    teardown do
      destroy_users
    end

    should "have a scope to list users alphabetically by username" do
      assert_equal ["egan", "joz", "matt", "mike", "ryan"], User.alphabetical.map(&:username)
    end

    should "have a scope to get only the playstation users" do
      assert_equal [@alex, @mike].to_set, User.for_playstation.to_set
    end

    should "have a scope to get the xbox users" do
      assert_equal [@ryan, @john, @matt].to_set, User.for_xbox.to_set
    end

    should "have a scope to get users for a console (using playstation value)" do
      assert_equal [@alex, @mike].to_set, User.for_console(2).to_set
    end

    should "have a scope to get users for a console (using xbox value)" do
      assert_equal [@ryan, @john, @matt].to_set, User.for_console(1).to_set
    end

    should "have a scope to get users who have a rating above a certain value" do
      assert_equal [@ryan, @matt].to_set, User.reputation_above(7).to_set
    end

    should "not allow a user to be created with the same team name on the same console" do
      # team name and console are the same as @alex, making it explicit here
      repeat = FactoryGirl.build(:user, username: 'unique', email: 'unique@example.com', team_name: 'TheHype', console: 2)
      deny repeat.valid?
    end

    should "not allow a user to be created if their password and password_confirmation do not match" do
      no_match = FactoryGirl.build(:user, username: 'unique', email: 'unique@example.com', team_name: 'different', console: 1, password: "notsecret")
      deny no_match.valid?
    end

    should "have a method to see if someone is an xbox user" do
      assert @ryan.xbox_user?
      deny   @mike.xbox_user?
    end

    should "have a method to see if someone is a playstation user" do
      assert @alex.playstation_user?
      deny   @matt.playstation_user?
    end

    should "have a method to get the name of the console a player is using" do
      assert_equal "Playstation 4", @alex.console_name
      assert_equal "Xbox One", @ryan.console_name
    end
  end
end

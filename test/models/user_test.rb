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

  context "With a set of users for testing" do
    setup do
      create_users
    end

    teardown do
      destroy_users
    end

    # I use this test when I add records for testing, so if something is broken
    # I won't have to wait for the rest of the tests to see it
    # should "have working records for testing" do
    #   assert_equal "egan", @alex.username
    #   assert_equal "ryan", @ryan.username
    #   assert_equal "joz", @john.username
    #   assert_equal "matt", @matt.username
    #   assert_equal "mike", @mike.username
    # end

    should "have a scope to list users alphabetically by username" do
      assert_equal ["egan", "joz", "matt", "mike", "ryan"], User.alphabetical.map(&:username)
    end

    should "have a scope to get only the playstation users" do
      ps_users = User.for_playstation
      assert ps_users.include?(@alex)
      assert ps_users.include?(@mike)
      assert_equal 2, ps_users.length
    end

    should "have a scope to get the xbox users" do
      xbox_users = User.for_xbox
      assert xbox_users.include?(@ryan)
      assert xbox_users.include?(@john)
      assert xbox_users.include?(@matt)
      assert_equal 3, xbox_users.length
    end

    should "have a scope to get users for a console" do
      ps_users = User.for_console(2)
      assert ps_users.include?(@alex)
      assert ps_users.include?(@mike)
      assert_equal 2, ps_users.length
      xbox_users = User.for_console(1)
      assert xbox_users.include?(@ryan)
      assert xbox_users.include?(@john)
      assert xbox_users.include?(@matt)
      assert_equal 3, xbox_users.length
    end

    should "have a scope to get users who have a rating above a certain value" do
      high_rated_users = User.reputation_above(7)
      assert high_rated_users.include?(@ryan)
      assert high_rated_users.include?(@matt)
      assert_equal 2, high_rated_users.length
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
  end
end

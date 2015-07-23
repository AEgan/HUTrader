require 'test_helper'

class TeamTest < ActiveSupport::TestCase
  # relationship tests
  should have_many(:players)

  # validation tests
  should validate_presence_of(:city)
  should validate_presence_of(:name)

  context "with a set of teams" do
    setup do
      create_teams
    end

    teardown do
      destroy_teams
    end

    should "have an alphabetical scope to order teams alphabetically by city, then name" do
      assert_equal [@islanders, @rangers, @flyers], Team.alphabetical.to_a
    end

    should "not let a team be created with the same name and city as an existing team" do
      repeat_team = FactoryGirl.build(:team, name: "Flyers", city: "Philadelphia")
      deny repeat_team.valid?
    end

    should "let a team be created with the same city name and different team name" do
      # done with my factories, but this test will make it explicit
      same_city = FactoryGirl.build(:team, name: "Phantoms", city: "Philadelphia")
      assert same_city.valid?
    end

    should "let a team be created with the same name but different city" do
      kitchener = FactoryGirl.build(:team, name: "Rangers", city: "Kitchener")
      assert kitchener.valid?
    end
  end
end

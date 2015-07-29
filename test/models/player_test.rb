require 'test_helper'

class PlayerTest < ActiveSupport::TestCase
  # relationships
  should belong_to(:team)
  should have_many(:trades).dependent(:destroy)

  # validation tests
  should validate_presence_of(:first_name)
  should validate_presence_of(:last_name)
  should validate_numericality_of(:overall).only_integer

  context "with a set of players to test with" do
    setup do
      create_teams
      create_players
    end

    teardown do
      destroy_players
      destroy_teams
    end

    should "have an alphabetical scope to get players in alphabetical order" do
      assert_equal [@giroux, @mcdonagh, @tavares, @voracek], Player.alphabetical
    end

    should "have a scope to get records ordered by their overall in-game rating (in decending order)" do
      assert_equal [@giroux, @tavares, @mcdonagh, @voracek], Player.by_overall
    end

    should "have a method to get a player's name in FIRST LAST format" do
      assert_equal "Claude Giroux", @giroux.proper_name
    end

    should "have a method to get a player's name in LAST, FIRST format" do
      assert_equal "Giroux, Claude", @giroux.name
    end

    should "not allow a player to be created if the team_id does not link to an existing team" do
      no_team = FactoryGirl.build(:player, team_id: -1)
      deny no_team.valid?
    end

    should "destroy a player if its associated team has beed destroyed" do
      @flyers.destroy
      deny Player.exists?(@giroux)
      deny Player.exists?(@voracek)
    end
  end
end

module Contexts
  module UserContexts
    def create_users
      @alex = FactoryGirl.create(:user)
      @ryan = FactoryGirl.create(:user, username: "ryan", email: "ryan@example.com", console: 1, team_name: "RyansTeam", reputation: 10)
      @john = FactoryGirl.create(:user, username: "joz", email: "joz@example.com", console: 1, team_name: "oswald", reputation: 7)
      @matt = FactoryGirl.create(:user, username: "matt", email: "matt@example.com", console: 1, team_name: "matteam", reputation: 9)
      @mike = FactoryGirl.create(:user, username: "mike", email: "mike@example.com", console: 2, team_name: "miketeam", reputation: 1)
    end

    def destroy_users
      @alex.destroy
      @ryan.destroy
      @john.destroy
      @matt.destroy
      @mike.destroy
    end
  end
end

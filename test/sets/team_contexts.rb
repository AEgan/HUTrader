module Contexts
  module TeamContexts
    def create_teams
      @islanders = FactoryGirl.create(:team)
      @rangers   = FactoryGirl.create(:team, name: "Rangers")
      @flyers    = FactoryGirl.create(:team, name: "Flyers", city: "Philadelphia")
    end

    def destroy_teams
      @islanders.destroy
      @rangers.destroy
      @flyers.destroy
    end
  end
end

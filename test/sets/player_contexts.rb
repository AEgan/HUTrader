module Contexts
  module PlayerContexts
    def create_players
      @giroux = FactoryGirl.create(:player, team: @flyers)
      @voracek = FactoryGirl.create(:player, team: @flyers, first_name: "Jakub", last_name: "Voracek", position: "LW", overall: 87)
      @tavares = FactoryGirl.create(:player, team: @islanders, first_name: "John", last_name: "Tavares")
      @mcdonagh = FactoryGirl.create(:player, team: @rangers, first_name: "Ryan", last_name: "Mcdonagh", overall: 89, position: "RD", style: "TWD")
    end

    def destroy_players
      @giroux.destroy
      @voracek.destroy
      @tavares.destroy
      @mcdonagh.destroy
    end
  end
end

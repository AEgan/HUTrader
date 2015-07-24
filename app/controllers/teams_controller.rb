class TeamsController < ApplicationController
  def index
    @teams = Team.alphabetical.includes(:players)
  end

  def show
    @team = Team.find(params[:id])
    @players = @team.players.by_overall.alphabetical
  end
end

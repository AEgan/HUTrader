class PlayersController < ApplicationController
  def show
    @player = Player.find(params[:id])
    @team = @player.team
  end
end

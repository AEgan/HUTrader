class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update]
  def index
    @open_trades = Trade.open.chronological.includes(:player, :user)
    @xbox_trades = @open_trades.select { |t| t.user.xbox_user? }
    @playstation_trades = @open_trades.select { |t| t.user.playstation_user? }
  end

  def show
  end

  def edit
  end

  def new
  end

  def create
  end

  def update
  end

  private
  def set_trade
    @trade = Trade.find(params[:id])
  end

  def trade_params
    params.require(:trade).permit(:player_id)
  end
end

class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update]
  before_action :check_login, only: [:new, :create]
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
    @trade = Trade.new
    @teams = Team.alphabetical.includes(:players)
  end

  def create
    @trade = Trade.new(trade_params)
    if @trade.save
      redirect_to @trade, notice: "Trade for #{@trade.player.proper_name} has been posted."
    else
      render :new
    end
  end

  def update
  end

  private
  def set_trade
    @trade = Trade.find(params[:id])
  end

  def trade_params
    params.require(:trade).permit(:player_id).merge({user_id: current_user.id})
  end
end

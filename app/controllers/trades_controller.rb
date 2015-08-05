class TradesController < ApplicationController
  before_action :set_trade, only: [:show, :edit, :update, :cancel]
  before_action :check_login, only: [:new, :create]
  def index
    @open_trades = Trade.open.chronological.includes(:player, :user)
    @xbox_trades = @open_trades.select { |t| t.user.xbox_user? }
    @playstation_trades = @open_trades.select { |t| t.user.playstation_user? }
  end

  def show
    @user = @trade.user
    @partner = @trade.partner
    @player = @trade.player
    @offers = @trade.offers.includes(:players, :user)
  end

  def cancel
    if !logged_in? || current_user.id != @trade.user_id || @trade.status != Trade::STATUSES['open']
      return authorization_failure
    else
      @trade.status = Trade::STATUSES['closed']
      @trade.save
      redirect_to @trade, notice: "Trade has been closed."
    end
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

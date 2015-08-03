class OffersController < ApplicationController
  before_action :set_trade, only: [:new, :show, :create]
  before_action :set_offer, only: [:show]
  before_action :check_login, only: [:new, :create]
  before_action :check_user_can_offer, only: [:new, :create]

  def new
    set_offer_associations
    @offer = Offer.new
    @offer.offer_players.build
  end

  def create
    @offer = Offer.new(offer_params.merge({trade_id: @trade.id, user_id: current_user.id}))
    if @offer.save
      redirect_to trade_offer_path(@trade, @offer), notice: "Your offer has been posted"
    else
      set_offer_associations
      render 'new'
    end
  end

  def show
  end

  private
  def set_offer
    @offer = Offer.find(params[:id])
  end

  def set_trade
    @trade = Trade.find(params[:trade_id])
  end

  def set_offer_associations
    @user = @trade.user
    @player = @trade.player
    @teams = Team.alphabetical.includes(:players)
  end

  def check_user_can_offer
    if current_user.id == @trade.user_id
      flash[:warning] = "You can't make an offer to your own trade."
      return redirect_to :home
    elsif Offer.where(user_id: current_user.id, trade_id: @trade.id).any?
      flash[:warning] = "You have already placed a trade offer."
      return redirect_to :home
    end
  end

  def offer_params
    params.require(:offer).permit(:coins, offer_players_attributes: [:id, :player_id])
  end
end

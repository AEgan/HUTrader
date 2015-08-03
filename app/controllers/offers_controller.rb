class OffersController < ApplicationController
  before_action :set_trade, only: [:new, :show, :create, :edit, :update, :accept]
  before_action :set_offer, only: [:show, :edit, :update, :accept]
  before_action :check_login, only: [:new, :create, :edit, :update, :accept]
  before_action :check_not_trade_creator, only: [:new, :create, :edit, :update]
  before_action :check_user_has_not_offered, only: [:new, :create]
  before_action :set_offer_associations, only: [:new, :edit]
  before_action :check_correct_user, only: [:edit, :update]

  def new
    @offer = Offer.new
    @offer.offer_players.build
  end

  def create
    @offer = Offer.new(offer_params.merge({trade_id: @trade.id, user_id: current_user.id}))
    if @offer.save
      redirect_to trade_offer_path(@trade, @offer), notice: "Your offer has been posted."
    else
      set_offer_associations
      render 'new'
    end
  end

  def show
    @players = @offer.players
  end

  def edit
  end

  def update
    if @offer.update(offer_params.merge({trade_id: @trade.id, user_id: current_user.id}))
      redirect_to trade_offer_path(@trade, @offer), notice: "Your offer has been updated."
    else
      set_offer_associations
      render 'edit'
    end
  end

  def accept
    if current_user.id != @trade.user_id
      flash[:warning] = "You are not authorized to perform this action."
      return redirect_to :home
    else
      @trade.partner_id = @offer.user_id
      @trade.status = Trade::STATUSES['partnered']
      @trade.save
      redirect_to @trade, notice: "You have accepted this offer."
    end
  end

  private
  def set_offer
    @offer = Offer.find(params[:id])
    if Offer.where(id: @offer.id, trade_id: @trade.id).empty?
      raise ActiveRecord::RecordNotFound.new("The requested offer does not exist.")
    end
  end

  def set_trade
    @trade = Trade.find(params[:trade_id])
  end

  def set_offer_associations
    @user = @trade.user
    @player = @trade.player
    @teams = Team.alphabetical.includes(:players)
  end

  def check_user_has_not_offered
    if Offer.where(user_id: current_user.id, trade_id: @trade.id).any?
      flash[:warning] = "You have already placed a trade offer."
      return redirect_to :home
    end
  end

  def check_correct_user
    if current_user.id != @offer.user_id
      flash[:warning] = "You are not authorized to perform this action."
      redirect_to :home
    end
  end

  def check_not_trade_creator
    if current_user.id == @trade.user_id
      flash[:warning] = "You can't make an offer to your own trade."
      return redirect_to :home
    end
  end

  def offer_params
    params.require(:offer).permit(:coins, offer_players_attributes: [:id, :player_id, :_destroy])
  end
end

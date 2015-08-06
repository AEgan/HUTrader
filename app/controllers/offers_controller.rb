class OffersController < ApplicationController
  before_action :set_trade
  before_action :set_offer, except: [:new, :create]
  before_action :check_login, except: :show
  before_action :check_not_trade_creator, only: [:new, :create, :edit, :update]
  before_action :check_user_has_not_offered, only: [:create]
  before_action :check_user_on_same_console, only: [:new, :create]
  before_action :set_offer_associations, only: [:new, :edit]
  before_action :check_correct_user, only: [:edit, :update]

  def new
    users_offer = current_users_offers
    if current_users_offers.any?
      redirect_to edit_trade_offer_path(@trade, current_users_offers.first)
    else
      @offer = Offer.new
      @offer.offer_players.build
    end
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
    @comments = @offer.comments
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
    if !current_user_posted_trade
      return authorization_failure
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
    if current_users_offers.any?
      return authorization_failure("You have already placed a trade offer.")
    end
  end

  def current_users_offers
    Offer.where(user_id: current_user.id, trade_id: @trade.id)
  end

  def check_correct_user
    if current_user.id != @offer.user_id
      return authorization_failure
    end
  end

  def check_not_trade_creator
    if current_user_posted_trade
      return authorization_failure("You can't make an offer to your own trade.")
    end
  end

  def check_user_on_same_console
    user = @trade.user
    if current_user.console != user.console
      return authorization_failure("This trade is for #{user.console_name}")
    end
  end

  def offer_params
    params.require(:offer).permit(:coins, offer_players_attributes: [:id, :player_id, :_destroy])
  end
end

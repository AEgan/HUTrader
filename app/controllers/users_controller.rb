class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]
  before_action :check_not_logged_in, only: [:new, :create]
  before_action :check_user_is_authorized, only: [:edit, :update]

  def new
    @user = User.new
  end

  def show
    @open_trades = @user.trades.open.includes(:offers, :player)
    @all_trades = @user.trades.includes(:offers, :player)
    @open_offers = @user.offers.open.includes(:trade, :players)
    @accepted_offers = @user.offers.accepted.includes(:trade, :players)
  end

  def edit
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user, notice: "Welcome to HUTrader, #{@user.username}!"
    else
      render 'new'
    end
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "Successfully updated your account."
    else
      render 'edit'
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :team_name, :console, :email)
  end

  # makes sure nobody is logged in before continuing
  def check_not_logged_in
    if logged_in?
      return authorization_failure("You are already logged in, so you cannot create an account.")
    end
  end

  # makes sure the logged in user is the user that is being edited/updated
  def check_user_is_authorized
    if !logged_in? || current_user.id != @user.id
      return authorization_failure
    end
  end
end

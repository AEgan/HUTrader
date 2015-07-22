class UsersController < ApplicationController
  before_action :set_user, only: [:edit, :update, :show]

  def new
    if logged_in?
      flash[:warning] = "You are already logged in, so you cannot create an account."
      redirect_to :home
    else
      @user = User.new
    end
  end

  def show
  end

  def edit
    if !logged_in? || current_user.id != @user.id
      flash[:warning] = "You are not authorized to preform this action."
      redirect_to :home
    end
  end

  def create
    if logged_in?
      flash[:warning] = "You are already logged in, so you cannot create an account."
      redirect_to :home
    else
      @user = User.new(user_params)
      if @user.save
        session[:user_id] = @user.id
        redirect_to @user, notice: "Welcome to HUTrader, #{@user.username}!"
      else
        render 'new'
      end
    end
  end

  def update
    if !logged_in? || current_user.id != @user.id
      flash[:warning] = "You are not authorized to preform this action."
      redirect_to :home
    else
      if @user.update(user_params)
        redirect_to @user, notice: "Successfully updated your account."
      else
        render 'edit'
      end
    end
  end

  private
  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:username, :password, :password_confirmation, :team_name, :console, :email)
  end
end

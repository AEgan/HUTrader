class SessionsController < ApplicationController
  before_action :already_logged_in, only: [:new, :create]

  def new
  end

  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      sign_in user
      self.current_user= user
      redirect_to user, notice: "Successfully signed in."
    else
      flash[:error] = "Invalid username or password."
      render 'new'
    end
  end

  def destroy
    notice = logged_in? ?  "Goodbye" : "You were not logged in."
    log_out
    self.current_user= nil
    redirect_to :home, notice: notice
  end

  private
  # method to redirect home if trying to log in when already logged in
  def already_logged_in
    if logged_in?
      redirect_to current_user, notice: "Already logged in."
    end
  end
end

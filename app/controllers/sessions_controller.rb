class SessionsController < ApplicationController
  def create
    user = User.find_by_username(params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect_to user, notice: "Successfully signed in"
    else
      flash[:error] = "Invalid username or password"
      render 'new'
    end
  end

  def destroy
    session[:user_id] = nil
    redirect_to :home, notice: 'Goodbye'
  end

end

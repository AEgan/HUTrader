class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # gracefully handle a record not found exception
  rescue_from ActiveRecord::RecordNotFound do |exception|
    render status: 404, file: "#{Rails.root}/public/404"
  end

  private
  def sign_in(user)
    session[:user_id] = user.id
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
  helper_method :current_user

  def current_user= (user)
    @current_user= user
  end

  def logged_in?
    current_user
  end
  helper_method :logged_in?

  def log_out
    reset_session
  end

  def check_login
    if !logged_in?
      flash[:warning] = "You are not authorized to preform this action."
      redirect_to :home
    end
  end
end

class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  helper_method :current_user

  before_action :require_login    

  private
  def current_user
    User.find(session[:user_id]) if session[:user_id]
  end
  def require_login
    redirect_to '/sessions/new' unless current_user
  end
  def logged_in
    redirect_to '/secrets' if current_user
  end
end 
class ApplicationController < ActionController::Base
  protect_from_forgery
  before_action :require_login
  # every page require's logging in unless specified
  helper_method :current_user
  # current_user can now be accessed by child controllers

  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def require_login
    # redirects to main page if user is not logged in
    redirect_to log_in_path unless session.include? :user_id
  end
end

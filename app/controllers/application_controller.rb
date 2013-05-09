class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

private
  def authorize
    if current_user
      true
    else
      redirect_to root_path
      false
    end
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end
end

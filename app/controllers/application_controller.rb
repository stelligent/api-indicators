class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  protected

  def current_user
    @current_user ||= true
  end

  def restrict_access
    authenticate_or_request_with_http_token do |token, options|
      ApiKey.exists?(access_token: token)
    end
  end
end

class ApplicationController < ActionController::Base
  protect_from_forgery

  protected

  def authenticate
    unless params[:api_key] == "test"
      render json: { error: "Unauthenticated" }
    end
  end
end

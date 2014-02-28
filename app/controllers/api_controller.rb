class ApiController < ActionController::Base
  before_filter :restrict_api_access, except: [:index, :show]

  def show
    response = { server_time: Time.now.to_i, ok: true }
    respond_ok response
  end

  private

  def respond_with response
    if response.respond_to?(:errors) and response.errors.present?
      respond_with_errors response.errors.full_messages
    elsif response.respond_to? :api_return_format
      respond_ok response.api_return_format
    else
      respond_ok response
    end
  end

  def respond_ok response
    render json: response
  end

  def respond_with_errors errors
    render json: { errors: errors }, status: 400
  end

  def restrict_api_access
    authenticate_or_request_with_http_token{ |token, options| User.exists?(api_key: token) }
  end
end

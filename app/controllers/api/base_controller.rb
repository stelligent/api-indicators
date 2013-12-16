class Api::BaseController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :restrict_api_access, except: [:index, :show]

  def show
    respond_ok({
      server_time: Time.now.to_i,
      ok: true
    })
  end

  private

  def respond_with(response)
    if response.respond_to?(:errors) && response.errors.present?
      respond_with_errors response.errors.full_messages
    else
      respond_ok response
    end
  end

  def respond_ok(response)
    render json: response
  end

  def respond_with_errors(errors)
    render json: { errors: errors }, status: 400
  end

  def restrict_api_access
    authenticate_or_request_with_http_token { |token, options| User.exists?(api_key: token) }
  end
end

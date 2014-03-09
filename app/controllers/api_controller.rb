class ApiController < ActionController::Base
  before_filter :restrict_api_access
  before_filter :authorize_admin, except: [:index, :show]

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
    authenticate_or_request_with_http_token{ |api_key, options| @current_user = User.find_by_api_key(api_key) }
  end

  def current_user
    @current_user
  end

  def available_projects
    @available_projects ||=
      if current_user.admin?
        Project.pluck(:id)
      else
        current_user.organization.projects.pluck(:id)
      end
  end

  def authorize_admin
    raise unless current_user.admin?
  rescue
    render(nothing: true) and return
  end
end

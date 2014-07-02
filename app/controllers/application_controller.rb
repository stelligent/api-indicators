class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user

  before_filter :authorize

  private

  def authorize
    current_user || redirect_to(login_path)
  end

  def authorize_admin
    redirect_to(root_path, alert: "Access denied") unless current_user.admin?
  end

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def available_projects
    @available_projects ||= current_user.admin? ? Project.pluck(:id) : current_user.organization.projects.pluck(:id)
  end

  def available_services
    @available_services ||= current_user.admin? ? Service.pluck(:id) : current_user.organization.services.pluck(:id)
  end
end

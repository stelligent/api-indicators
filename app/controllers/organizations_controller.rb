class OrganizationsController < ApplicationController
  before_filter :authorize_admin
  before_filter :set_organization, only: [:show]

  def index
    @organizations = Organization.all
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      redirect_to organizations_path, notice: "Organization created"
    else
      render action: "new"
    end
  end

  private

  def authorize_admin
    redirect_to(root_path, alert: "Access denied") unless current_user.admin?
  end

  def set_organization
    @organization = Organization.find(params[:id])
  end
end

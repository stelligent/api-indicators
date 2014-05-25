class OrganizationsController < ApplicationController
  before_filter :authorize_admin
  before_filter :set_organization, only: [:show, :edit, :update, :destroy]

  def index
    @organizations = Organization.all
  end

  def show
  end

  def new
    @organization = Organization.new
  end

  def edit
  end

  def create
    @organization = Organization.new(params[:organization])

    if @organization.save
      redirect_to organizations_path, notice: "Organization created"
    else
      render action: "new"
    end
  end

  def update
    if @organization.update_attributes(params[:organization])
      redirect_to organization_path, notice: "Organization updated"
    else
      render action: "edit"
    end
  end

  def destroy
    @organization.destroy
    redirect_to organizations_path, notice: "Organization #{@organization.name} destroyed"
  end

  private

  def set_organization
    @organization = Organization.find(params[:id])
  end
end

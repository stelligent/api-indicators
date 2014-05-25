class Api::OrganizationsController < ApiController
  before_filter :authorize_admin
  before_filter :get_organization, only: [:show, :update, :destroy]

  def index
    @organizations = Organization.all

    render json: @organizations
  end

  def show
    render json: @organization
  end

  def create
    @organization = Organization.new(params[:organization])
    @organization.save

    render json: @organization
  end

  def update
    @organization.update_attributes(params[:organization])

    render json: @organization
  end

  def destroy
    @organization.destroy

    render json: @organization
  end

  private

  def get_organization
    @organization = Organization.find(params[:id])
  rescue
    render nothing: true
  end
end

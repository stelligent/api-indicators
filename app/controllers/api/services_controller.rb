class Api::ServicesController < ApiController
  before_filter :get_services, only: :index
  before_filter :get_service, only: [:show, :update, :destroy]

  def index
    respond_with @services
  end

  def show
    respond_with @service
  end

  def create
    @service = Service.new(params[:service])
    @service.save
    respond_with @service
  end

  def update
    @service.update_attributes(params[:service])
    respond_with @service
  end

  def destroy
    @service.destroy
    respond_with @service
  end

  private

  def get_services
    @services = Service.all
  end

  def get_service
    @service = Service.find_by_id(params[:id])
  end
end

class Api::ServicesController < ApiController
  before_filter :get_service, only: [:show, :update, :destroy]

  # GET /api/services
  def index
    respond_with Service.all.map(&:api_return_format)
  end

  # POST /api/services
  def create
    @service = Service.new(params[:service])
    @service.save
    respond_with @service
  end

  # GET /api/services/:id
  def show
    respond_with @service
  end

  # PUT /api/services/:id
  def update
    @service.update_attributes(params[:service])
    respond_with @service
  end

  # DELETE /api/services/:id
  def destroy
    @service.destroy
    respond_with @service
  end

  private

  def get_service
    @service ||= Service.find(params[:id]) rescue render(nothing: true) and return
  end
end

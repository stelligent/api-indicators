class Api::ServicesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :get_service, only: [ :show, :update, :destroy ]
  before_filter :restrict_access, except: [ :index, :show ]

  # GET /api/services
  def index
    @services = Service.all.map(&:api_return_format)
    render json: @services
  end

  # POST /api/services
  def create
    @service = Service.new(params[:service])
    if @service.save
      render json: @service.api_return_format
    else
      render json: @service.errors
    end
  end

  # GET /api/services/:id
  def show
    render json: @service.api_return_format
  end

  # PUT /api/services/:id
  def update
    if @service.update_attributes(params[:service])
      render json: @service.api_return_format
    else
      render json: @service.errors
    end
  end

  # DELETE /api/services/:id
  def destroy
    if @service.destroy
      render json: @service.api_return_format
    else
      render json: @service.errors
    end
  end

  private

  def get_service
    @service = Service.find(params[:id]) rescue render(json: { error: "No such service" }) and return
  end
end

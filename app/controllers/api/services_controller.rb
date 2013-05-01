class Api::ServicesController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :authenticate, except: [ :index, :show ]

  # GET /api/services
  def index
    @services = Service.all.map do |service|
      return_format service
    end
    render json: @services
  end

  # POST /api/services
  def create
    @service = Service.new(params[:service])
    if @service.save
      render json: return_format(@service)
    else
      render json: @service.errors
    end
  end

  # GET /api/services/:id
  def show
    @service = Service.find(params[:id])
    render json: return_format(@service)
  end

  # PUT /api/services/:id
  def update
  end

  # DELETE /api/services/:id
  def destroy
  end

  private

  def return_format service
    {
      id: service.id,
      name: service.name
    }
  end
end

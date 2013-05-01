class Api::IndicatorsController < ApplicationController
  # GET /api/indicators
  def index
    @indicators = Indicator.all.map do |indicator|
      return_format indicator
    end
    render json: @indicators
  end

  # GET /api/indicators/:id
  def show
    @indicator = Indicator.find(params[:id])
    render json: return_format(@indicator)
  end

  private

  def return_format indicator
    {
      id: indicator.id,
      project: indicator.project.name,
      service: indicator.service.name,
      status: indicator.current_status.name
    }
  end
end

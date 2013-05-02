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
      project_id: indicator.project.id,
      service_id: indicator.service.id,
      current_status_id: indicator.current_status.id
    }
  end
end

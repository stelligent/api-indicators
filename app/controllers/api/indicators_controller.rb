class Api::IndicatorsController < ApplicationController
  # GET /api/projects/:project_id/indicators
  def index
    @indicators = Project.find(params[:project_id]).indicators.map do |indicator|
      {
        id: indicator.id,
        type: indicator.type.name,
        state: indicator.current_state.name
      }
    end
    render json: @indicators
  end
end

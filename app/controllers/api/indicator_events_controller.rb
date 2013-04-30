class Api::IndicatorEventsController < ApplicationController
  # GET /api/projects/:project_id/indicators/:indicator_id/events
  def index
    @events = Indicator.find(:indicator_id).events
    render json: @events
  end
end

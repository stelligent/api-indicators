class Api::IndicatorEventsController < ApplicationController
  # GET /api/projects/:project_id/indicators/:indicator_id/events
  def index
    @events = Indicator.find(params[:indicator_id]).events.map do |event|
      {
        id: event.id,
        time: event.created_at,
        state: event.state.name,
        description: event.description || ""
      }
    end
    render json: @events
  end
end

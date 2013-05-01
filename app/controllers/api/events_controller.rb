class Api::EventsController < ApplicationController
  # GET /api/indicators/:id/events
  def index
    @events = Indicator.find(params[:indicator_id]).events.map do |event|
      return_format event
    end
    render json: @events
  end

  private

  def return_format event
    {
      id: event.id,
      time: event.created_at,
      state: event.status.name,
      message: event.message || ""
    }
  end
end

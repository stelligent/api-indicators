class Api::EventsController < ApplicationController
  # GET /api/indicators/:indicator_id/events
  def index
    @events = Indicator.find(params[:indicator_id]).events.map do |event|
      return_format event
    end
    render json: @events
  end

  # POST /api/indicators/:indicator_id/events
  def create
    @event = Indicator.find(params[:indicator_id]).events.new(params[:event])
    if @event.save
      render json: return_format(@event)
    else
      render json: @event.errors
    end
  end

  # GET /api/indicators/:indicator_id/events/:id
  def show
    @event = Indicator.find(params[:indicator_id]).events.find(params[:id])
    render json: return_format(@event)
  end

  # PUT /api/indicators/:indicator_id/events/:id
  def update
    @event = Indicator.find(params[:indicator_id]).events.find(params[:id])
    if @event.update_attributes(params[:event])
      render json: return_format(@event)
    else
      render json: @event.errors
    end
  end

  # DELETE /api/indicators/:indicator_id/events/:id
  def destroy
    @event = Indicator.find(params[:indicator_id]).events.find(params[:id])
    if @event.destroy
      render json: return_format(@event)
    else
      render json: @event.errors
    end
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

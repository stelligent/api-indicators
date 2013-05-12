class Api::EventsController < ApiController
  before_filter :get_events
  before_filter :get_event, only: [ :show, :update, :destroy ]

  # GET /api/indicators/:indicator_id/events
  def index
    respond_with @events.map(&:api_return_format)
  end

  # POST /api/indicators/:indicator_id/events
  def create
    @event = @events.new(params[:event])
    @event.save
    respond_with @event
  end

  # GET /api/indicators/:indicator_id/events/:id
  def show
    respond_with @event
  end

  # PUT /api/indicators/:indicator_id/events/:id
  def update
    @event.update_attributes(params[:event])
    respond_with @event
  end

  # DELETE /api/indicators/:indicator_id/events/:id
  def destroy
    @event.destroy
    respond_with @event
  end

private

  def get_events
    @events ||= Indicator.find(params[:indicator_id]).events.includes(:status) rescue render(nothing: true) and return
  end

  def get_event
    @event ||= @events.find(params[:id]) rescue render(nothing: true) and return
  end
end

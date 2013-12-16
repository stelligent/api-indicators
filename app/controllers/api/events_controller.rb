class Api::EventsController < Api::BaseController
  before_filter :get_events
  before_filter :get_event, only: [:show, :update, :destroy]

  def index
    respond_with @events
  end

  def show
    respond_with @event
  end

  def create
    @event = @events.new(params[:event])
    @event.save
    respond_with @event
  end

  def update
    @event.update_attributes(params[:event])
    respond_with @event
  end

  def destroy
    @event.destroy
    respond_with @event
  end

  private

  def get_events
    @indicator = Indicator.find_by_id(params[:indicator_id])
    @events = @indicator.events.includes(:status) if @indicator
  end

  def get_event
    @event = @events.find_by_id(params[:id]) if @events
  end
end

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
    @events = Indicator.find(params[:indicator_id]).events.includes(:status) rescue render(nothing: true) and return
  end

  def get_event
    @event ||= @events.find(params[:id]) rescue render(nothing: true) and return
  end
end

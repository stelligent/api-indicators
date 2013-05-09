class Api::StatusesController < ApiController
  # GET /api/statuses
  def index
    @statuses = Status.all.map(&:api_return_format)
    render json: @statuses
  end
end

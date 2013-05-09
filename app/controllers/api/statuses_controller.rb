class Api::StatusesController < ApiController
  # GET /api/statuses
  def index
    render json: Status.all.map(&:api_return_format)
  end
end

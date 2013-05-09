class Api::StatusesController < ApiController
  # GET /api/statuses
  def index
    render json: { statuses: Status.all.map(&:api_return_format) }
  end
end

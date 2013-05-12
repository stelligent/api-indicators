class Api::StatusesController < ApiController
  # GET /api/statuses
  def index
    respond_with Status.all.map(&:api_return_format)
  end
end

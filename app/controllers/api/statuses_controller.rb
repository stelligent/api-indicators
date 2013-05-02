class Api::StatusesController < ApplicationController
  # GET /api/statuses
  def index
    @statuses = Status.all.map do |status|
      return_format status
    end
    render json: @statuses
  end

  private

  def return_format status
    {
      id: status.id,
      name: status.name
    }
  end
end

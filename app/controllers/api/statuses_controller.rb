class Api::StatusesController < ApiController
  def index
    respond_with Status.all
  end
end

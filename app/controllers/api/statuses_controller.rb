class Api::StatusesController < Api::BaseController
  def index
    respond_with Status.all
  end
end

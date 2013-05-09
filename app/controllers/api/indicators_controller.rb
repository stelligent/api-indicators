class Api::IndicatorsController < ApiController
  # GET /api/indicators
  def index
    render json: Indicator.all.map(&:api_return_format)
  end

  # GET /api/indicators/:id
  def show
    begin
      @indicator = Indicator.find(params[:id])
    rescue
      render(json: { error: "No such indicator" }) and return
    end

    render json: @indicator.api_return_format
  end
end

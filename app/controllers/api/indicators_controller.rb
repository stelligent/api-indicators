class Api::IndicatorsController < Api::BaseController
  before_filter :get_indicators, onle: :index
  before_filter :get_indicator, only: [:show, :update]

  def index
    respond_with @indicators
  end

  def show
    respond_with @indicator
  end

  def update
    @indicator.update_attributes(params[:indicator])
    respond_with @indicator
  end

  private

  def get_indicators
    @indicators = Indicator.includes(:project, :service, :events).all
  end

  def get_indicator
    @indicator = Indicator.find_by_id(params[:id])
  end
end

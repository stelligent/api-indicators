class IndicatorsController < ApplicationController
  before_filter :set_indicator, only: :show

  def index
    @services = Service.all.sort_by(&:id)
    @indicator_groups = Indicator.includes(:project, :events).all.
      group_by(&:project).
      map { |group| group[1].sort_by!(&:service_id); group }
  end

  def show
    if @indicator.custom_url.present?
      redirect_to(@indicator.custom_url) and return
    end
  end

  private

  def set_indicator
    @indicator = Indicator.find(params[:id])
  end
end

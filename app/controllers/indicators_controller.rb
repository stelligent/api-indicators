class IndicatorsController < ApplicationController
  def index
    @services = Service.all.sort_by(&:id)
    @indicator_groups = Indicator.includes(:project, :events).all.
      group_by(&:project).
      map { |group| group[1].sort_by!(&:service_id); group }
  end

  def show
    begin
      @indicator = Indicator.find(params[:id])
      raise unless @indicator.has_page
    rescue
      redirect_to(root_path) and return
    end

    respond_to do |format|
      format.html
    end
  end
end

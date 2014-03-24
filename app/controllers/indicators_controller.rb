class IndicatorsController < ApplicationController
  before_filter :set_indicator, only: :show

  def index
    @services = Service.order(:id)

    @indicator_groups = Indicator.where(project_id: available_projects).includes(:project, :events).all.
      group_by(&:project).
      map { |group| group[1].sort_by!(&:service_id); group }
  end

  def show
    if @indicator.custom_url.present?
      redirect_to(@indicator.custom_url)
    end
  end

  private

  def set_indicator
    @indicator = Indicator.find(params[:id])

    redirect_to(root_path) unless available_projects.include?(@indicator.project_id)
  end
end

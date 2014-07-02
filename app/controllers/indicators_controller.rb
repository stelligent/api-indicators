class IndicatorsController < ApplicationController
  before_filter :set_indicator, only: :show

  def index
    @services = Service.find(available_services).sort_by(&:id)

    @indicator_groups = Indicator.where(project_id: available_projects, service_id: available_services).includes(:project, :events).all.
      group_by(&:project).
      map { |project, indicators| [project, indicators.sort_by(&:service_id)] }
  end

  def show
    if @indicator.custom_url.present?
      redirect_to(@indicator.custom_url)
    end
  end

  private

  def set_indicator
    @indicator = Indicator.find(params[:id])

    redirect_to(root_path) unless available_projects.include?(@indicator.project_id) and available_services.include?(@indicator.service_id)
  end
end

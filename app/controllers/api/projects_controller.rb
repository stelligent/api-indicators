class Api::ProjectsController < Api::BaseController
  before_filter :get_projects, only: :index
  before_filter :get_project, only: [:show, :update, :destroy]

  def index
    respond_with @projects
  end

  def show
    respond_with @project
  end

  def create
    @project = Project.new(params[:project])
    @project.save
    respond_with @project
  end

  def update
    @project.update_attributes(params[:project])
    respond_with @project
  end

  def destroy
    @project.destroy
    respond_with @project
  end

  private

  def get_projects
    @projects = Project.all
  end

  def get_project
    @project = Project.find_by_id(params[:id])
  end
end

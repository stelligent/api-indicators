class Api::ProjectsController < ApiController
  before_filter :get_project, only: [ :show, :update, :destroy ]

  # GET /api/projects
  def index
    respond_with Project.all.map(&:api_return_format)
  end

  # POST /api/projects
  def create
    @project = Project.new(params[:project])
    @project.save
    respond_with @project
  end

  # GET /api/projects/:id
  def show
    respond_with @project
  end

  # PUT /api/projects/:id
  def update
    @project.update_attributes(params[:project])
    respond_with @project
  end

  # DELETE /api/projects/:id
  def destroy
    @project.destroy
    respond_with @project
  end

private

  def get_project
    @project ||= Project.find(params[:id]) rescue render(nothing: true) and return
  end
end

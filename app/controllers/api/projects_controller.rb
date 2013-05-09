class Api::ProjectsController < ApiController
  before_filter :get_project, only: [ :show, :update, :destroy ]
  before_filter :restrict_api_access, except: [ :index, :show ]

  # GET /api/projects
  def index
    @projects = Project.all.map(&:api_return_format)
    render json: @projects
  end

  # POST /api/projects
  def create
    @project = Project.new(params[:project])
    if @project.save
      render json: @project.api_return_format
    else
      render json: @project.errors
    end
  end

  # GET /api/projects/:id
  def show
    render json: @project.api_return_format
  end

  # PUT /api/projects/:id
  def update
    if @project.update_attributes(params[:project])
      render json: @project.api_return_format
    else
      render json: @project.errors
    end
  end

  # DELETE /api/projects/:id
  def destroy
    if @project.destroy
      render json: @project.api_return_format
    else
      render json: @project.errors
    end
  end

  private

  def get_project
    @project = Project.find(params[:id]) rescue render(json: { error: "No such project" }) and return
  end
end

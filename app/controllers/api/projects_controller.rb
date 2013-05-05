class Api::ProjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token
  before_filter :get_project, only: [ :show, :update, :destroy ]
  before_filter :restrict_access, except: [ :index, :show ]

  # GET /api/projects
  def index
    @projects = Project.all.map do |project|
      return_format project
    end
    render json: @projects
  end

  # POST /api/projects
  def create
    @project = Project.new(params[:project])
    if @project.save
      render json: return_format(@project)
    else
      render json: @project.errors
    end
  end

  # GET /api/projects/:id
  def show
    render json: return_format(@project)
  end

  # PUT /api/projects/:id
  def update
    if @project.update_attributes(params[:project])
      render json: return_format(@project)
    else
      render json: @project.errors
    end
  end

  # DELETE /api/projects/:id
  def destroy
    if @project.destroy
      render json: return_format(@project)
    else
      render json: @project.errors
    end
  end

  private

  def get_project
    @project = Project.find(params[:id]) rescue render(json: { error: "No such project" }) and return
  end

  def return_format project
    {
      id: project.id,
      name: project.name
    }
  end
end

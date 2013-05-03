class Api::ProjectsController < ApplicationController
  skip_before_filter :verify_authenticity_token
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
    @project = Project.find(params[:id])
    render json: return_format(@project)
  end

  # PUT /api/projects/:id
  def update
    @project = Project.find(params[:id])
    if @project.update_attributes(params[:project])
      render json: return_format(@project)
    else
      render json: @project.errors
    end
  end

  # DELETE /api/projects/:id
  def destroy
    @project = Project.find(params[:id])
    if @project.destroy
      render json: return_format(@project)
    else
      render json: @project.errors
    end
  end

  private

  def return_format project
    {
      id: project.id,
      name: project.name
    }
  end
end

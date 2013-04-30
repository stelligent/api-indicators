class Api::ProjectsController < ApplicationController
  before_filter :authenticate, except: [ :index, :show ]

  # GET /api/projects
  def index
    @projects = Project.all
    render json: @projects
  end

  # POST /api/projects
  def create
  end

  # GET /api/projects/:id
  def show
    @project = Project.find(params[:id])
    render json: @project
  end

  # PUT /api/projects/:id
  def update
  end

  # DELETE /api/projects/:id
  def destroy
  end
end

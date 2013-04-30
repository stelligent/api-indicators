class Api::IndicatorTypesController < ApplicationController
  before_filter :authenticate, except: [ :index, :show ]

  # GET /api/indicator_types
  def index
    @indicator_types = IndicatorType.all
    render json: @indicator_types
  end

  # POST /api/indicator_types
  def create
  end

  # GET /api/indicator_types/:id
  def show
    @indicator_types = IndicatorType.find(params[:id])
    render json: @indicator_type
  end

  # PUT /api/indicator_types/:id
  def update
  end

  # DELETE /api/indicator_types/:id
  def destroy
  end
end

class Api::IndicatorTypesController < ApplicationController
  before_filter :authenticate, except: [ :index, :show ]

  # GET /api/services
  def index
    @indicator_types = IndicatorType.all.map do |indicator_type|
      {
        id: indicator_type.id,
        name: indicator_type.name
      }
    end
    render json: @indicator_types
  end

  # POST /api/services
  def create
  end

  # GET /api/services/:id
  def show
    @indicator_type = IndicatorType.find(params[:id])
    render json: {
      id: @indicator_type.id,
      name: @indicator_type.name
    }
  end

  # PUT /api/services/:id
  def update
  end

  # DELETE /api/services/:id
  def destroy
  end
end

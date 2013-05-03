class IndicatorsController < ApplicationController
  def show
    begin
      @indicator = Indicator.find(params[:id])
      raise unless @indicator.has_page
    rescue
      redirect_to(root_path) and return
    end

    respond_to do |format|
      format.html
    end
  end
end

class PagesController < ApplicationController
  def root
    @projects = Project.all
    @services = Service.all
  end

  def docs
  end
end

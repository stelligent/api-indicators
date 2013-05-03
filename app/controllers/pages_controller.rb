class PagesController < ApplicationController
  def root
    @projects = Project.all
    @services = Service.all
  end
end

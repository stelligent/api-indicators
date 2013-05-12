class PagesController < ApplicationController
  before_filter :authorize, only: [ :docs ]

  def docs
  end
end

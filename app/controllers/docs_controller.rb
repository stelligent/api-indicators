class DocsController < ApplicationController
  before_filter :authorize

  def show
    @resources = [
      ["projects", [ "list", "get", "create", "update", "delete" ]],
      ["services", [ "list", "get", "create", "update", "delete" ]],
      ["indicators", [ "list", "get", "update" ]],
      ["events", [ "list", "get", "create", "update", "delete" ]],
      ["statuses", [ "list" ]]
    ]
  end
end

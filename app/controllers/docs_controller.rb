class DocsController < ApplicationController
  def show
    @resources = [
      ["projects", %w{list get create update delete}],
      ["services", %w{list get create update delete}],
      ["indicators", %w{list get update}],
      ["events", %w{list get create update delete}],
      ["statuses", %w{list}]
    ]
  end
end

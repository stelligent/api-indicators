class AddProjectIdServiceIdIndexToIndicators < ActiveRecord::Migration
  def change
    add_index :indicators, [ :project_id, :service_id ], unique: true
  end
end

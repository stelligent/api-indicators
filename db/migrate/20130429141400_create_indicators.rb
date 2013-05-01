class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.integer :service_id
      t.integer :project_id
    end
  end
end

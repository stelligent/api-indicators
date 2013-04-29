class CreateIndicators < ActiveRecord::Migration
  def change
    create_table :indicators do |t|
      t.integer :indicator_type_id
      t.integer :project_id
    end
  end
end

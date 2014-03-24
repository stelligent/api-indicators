class CreateOrganizationsProjects < ActiveRecord::Migration
  def change
    create_table :organizations_projects, id: false do |t|
      t.integer :organization_id
      t.integer :project_id
    end
  end
end

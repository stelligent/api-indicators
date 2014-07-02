class CreateOrganizationsServices < ActiveRecord::Migration
  def change
    create_table :organizations_services, id: false do |t|
      t.integer :organization_id
      t.integer :service_id
    end
  end
end

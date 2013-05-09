class AddDescriptionToProjectsAndServices < ActiveRecord::Migration
  def change
    add_column :projects, :description, :string
    add_column :services, :description, :string
  end
end

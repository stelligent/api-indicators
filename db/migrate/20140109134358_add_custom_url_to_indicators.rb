class AddCustomUrlToIndicators < ActiveRecord::Migration
  def up
    remove_column :indicators, :has_page
    add_column :indicators, :custom_url, :string, default: nil
  end

  def down
    remove_column :indicators, :custom_url
    add_column :indicators, :has_page, :boolean, default: true
  end
end

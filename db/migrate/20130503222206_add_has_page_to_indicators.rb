class AddHasPageToIndicators < ActiveRecord::Migration
  def change
    add_column :indicators, :has_page, :boolean, default: true
  end
end

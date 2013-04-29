class CreateIndicatorTypes < ActiveRecord::Migration
  def change
    create_table :indicator_types do |t|
      t.string :name
    end
  end
end

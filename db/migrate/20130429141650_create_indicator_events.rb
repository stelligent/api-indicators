class CreateIndicatorEvents < ActiveRecord::Migration
  def change
    create_table :indicator_events do |t|
      t.integer :indicator_id
      t.integer :indicator_state_id
      t.text :description

      t.timestamps
    end
  end
end

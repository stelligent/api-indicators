class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :indicator_id
      t.integer :status_id
      t.text :message

      t.timestamps
    end
  end
end

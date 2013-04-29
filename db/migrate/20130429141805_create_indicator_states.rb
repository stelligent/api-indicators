class CreateIndicatorStates < ActiveRecord::Migration
  def change
    create_table :indicator_states do |t|
      t.string :name
    end
  end
end

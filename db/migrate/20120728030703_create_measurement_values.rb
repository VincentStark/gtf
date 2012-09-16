class CreateMeasurementValues < ActiveRecord::Migration
  def change
    create_table :measurement_values do |t|
      t.integer  :measurement_id, :null => false
      t.integer  :entity_id, :null => false
      t.integer  :value, :limit => 8, :null => false
      t.datetime :collected_at, :null => false

      t.timestamps
    end

    add_index :measurement_values, [ :measurement_id, :entity_id, :value, :collected_at ],
              unique: true, name: "index_measurement_values_composite1"
    add_index :measurement_values, [ :measurement_id, :entity_id, :collected_at ],
              unique: true, name: "index_measurement_values_composite2"
  end
end

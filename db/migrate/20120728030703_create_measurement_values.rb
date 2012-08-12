class CreateMeasurementValues < ActiveRecord::Migration
  def change
    create_table :measurement_values do |t|
      t.integer :measurement_id, :null => false
      t.integer :word_id
      t.integer :site_id
      t.integer :value, :limit => 8, :null => false
      t.datetime :collected_at, :null => false

      t.timestamps
    end

    add_index :measurement_values, [ :measurement_id, :word_id, :value, :collected_at ],
              unique: true, name: "index_measurement_values_composite1"
    add_index :measurement_values, [ :measurement_id, :site_id, :value, :collected_at ],
              unique: true, name: "index_measurement_values_composite2"
    add_index :measurement_values, [ :measurement_id, :word_id, :site_id, :collected_at ],
              unique: true, name: "index_measurement_values_composite3"
  end
end

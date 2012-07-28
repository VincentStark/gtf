class CreateAttributeValues < ActiveRecord::Migration
  def change
    create_table :attribute_values do |t|
      t.integer :attribute_id, :null => false
      t.integer :entity_id, :null => false
      t.string :value, :null => false
      t.datetime :collected_at, :null => false

      t.timestamps
    end

    add_index :attribute_values, [ :attribute_id, :entity_id, :value, :collected_at ],
              unique: true, name: "index_attribute_values_composite1"
  end
end

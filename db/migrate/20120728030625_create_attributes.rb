class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :name, :null => false
      t.integer :mtype, :null => false
      t.string :url, :null => false

      t.timestamps
    end

    add_index :measurements, [ :name, :mtype, :url ], unique: true
  end
end

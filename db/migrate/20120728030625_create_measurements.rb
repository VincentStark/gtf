class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :name, :null => false
      t.string :url,  :null => false

      t.timestamps
    end

    add_index :measurements, [ :name, :url ], unique: true
  end
end

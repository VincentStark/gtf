class CreateMeasurements < ActiveRecord::Migration
  def change
    create_table :measurements do |t|
      t.string :name, :null => false

      t.timestamps
    end

    add_index :measurements, :name, unique: true
  end
end

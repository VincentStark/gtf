class CreateAttributes < ActiveRecord::Migration
  def change
    create_table :attributes do |t|
      t.string :attribute, :null => false

      t.timestamps
    end

    add_index :attributes, :attribute, unique: true
  end
end

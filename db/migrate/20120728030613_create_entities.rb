class CreateEntities < ActiveRecord::Migration
  def change
    create_table :entities do |t|
      t.string  :name,  :null => false
      t.integer :etype, :null => false

      t.timestamps
    end

    add_index :entities, :name, unique: true
    add_index :entities, [ :name, :etype ], unique: true
  end
end

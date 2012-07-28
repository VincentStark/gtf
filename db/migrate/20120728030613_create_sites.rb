class CreateSites < ActiveRecord::Migration
  def change
    create_table :sites do |t|
      t.string :site, :null => false

      t.timestamps
    end

    add_index :sites, :site, unique: true
  end
end

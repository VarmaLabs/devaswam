class CreateOfferings < ActiveRecord::Migration
  def self.up
    create_table :offerings do |t|
      t.string :name
      t.integer :deity_id
      t.integer :temple_id
      t.float :price
      t.string :notes
      t.timestamps
    end
  end

  def self.down
    drop_table :offerings
  end
end
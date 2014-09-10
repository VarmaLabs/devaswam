class CreateDeities < ActiveRecord::Migration
  def self.up
    create_table :deities do |t|
      t.string :name
      t.text :description
      t.integer :temple_id
      t.integer :trust_id
      t.timestamps
    end
  end

  def self.down
    drop_table :deities
  end
end
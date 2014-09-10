class CreateTemples < ActiveRecord::Migration
  def self.up
    create_table :temples do |t|
      t.string :name
      t.text :description
      t.integer :trust_id
      t.timestamps
    end
  end

  def self.down
    drop_table :temples
  end
end
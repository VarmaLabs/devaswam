class CreateTrusts < ActiveRecord::Migration
  def self.up
    create_table :trusts do |t|
      t.string :name
      t.string :status
      t.string :email
      t.string :phone
      t.string :address
      t.text :description
      t.timestamps
    end
  end

  def self.down
    drop_table :trusts
  end
end
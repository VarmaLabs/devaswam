class CreateAdmins < ActiveRecord::Migration
  def self.up
    create_table :admins do |t|
      t.string :name
      t.string :username
      t.string :status
      t.string :email
      t.string :phone
      t.string :address
      t.integer :trust_id
      t.string :password_digest
      t.string :auth_token
      t.timestamps
    end
  end

  def self.down
    drop_table :admins
  end
end
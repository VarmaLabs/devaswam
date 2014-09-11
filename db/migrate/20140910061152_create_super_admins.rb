class CreateSuperAdmins < ActiveRecord::Migration
  def self.up
    create_table :super_admins do |t|
      t.string :name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :auth_token
      t.timestamps
    end
  end

  def self.down
    drop_table :super_admins
  end
end
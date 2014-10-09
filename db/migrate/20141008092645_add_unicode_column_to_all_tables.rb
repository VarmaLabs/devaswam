class AddUnicodeColumnToAllTables < ActiveRecord::Migration
  def change

    add_column :super_admins, :unicode_name, :string
    add_column :trust_admins, :unicode_name, :string
    add_column :trusts, :unicode_name, :string
    add_column :temples, :unicode_name, :string
    add_column :deities, :unicode_name, :string
    add_column :offerings, :unicode_name, :string

  end
end

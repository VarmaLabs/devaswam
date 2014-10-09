class UpdateOfferings < ActiveRecord::Migration
  def change
    add_column :offerings, :devaswam_share, :float
    add_column :offerings, :shanti_share, :float
    add_column :offerings, :kazhakam_share, :float
  end
end

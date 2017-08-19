class AddUsersToBand < ActiveRecord::Migration[5.1]
  def change
     add_column(:users, :band_id, :integer)
  end
end

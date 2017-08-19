class UsersAndBands < ActiveRecord::Migration[5.1]
  def change
  create_table :bands_users do |t|
    t.belongs_to :user
    t.belongs_to :band
  end
  remove_column(:users, :band_id)
  end
end
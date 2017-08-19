class AddNameColumn < ActiveRecord::Migration[5.1]
  def change
    add_column(:songs, :name, :string)
  end
end

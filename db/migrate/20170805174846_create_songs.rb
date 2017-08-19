class CreateSongs < ActiveRecord::Migration[5.1]
  def change
    create_table :songs do |t|
      t.string :content
      t.datetime :date
      t.references :band
    end
  end
end

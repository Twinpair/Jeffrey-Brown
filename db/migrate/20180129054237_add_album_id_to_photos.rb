class AddAlbumIdToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :album_id, :integer
  end

  add_index :photos, :album_id
  add_foreign_key :photos, :albums
end

class AddIndexAndForeignKeyToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_index :photos, :album_id
    add_foreign_key :photos, :albums
  end
end

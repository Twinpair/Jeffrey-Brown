class CreateAlbums < ActiveRecord::Migration[5.0]
  def change
    create_table :albums do |t|
      t.string :name
      t.text :description
      t.integer :order_listed

      t.timestamps
    end
  end
end

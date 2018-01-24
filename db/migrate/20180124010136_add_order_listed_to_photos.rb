class AddOrderListedToPhotos < ActiveRecord::Migration[5.0]
  def change
    add_column :photos, :order_listed, :integer
  end
end

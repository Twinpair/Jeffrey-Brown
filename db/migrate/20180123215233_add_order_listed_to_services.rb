class AddOrderListedToServices < ActiveRecord::Migration[5.0]
  def change
    add_column :services, :order_listed, :integer
  end
end

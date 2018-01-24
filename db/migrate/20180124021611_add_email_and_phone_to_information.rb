class AddEmailAndPhoneToInformation < ActiveRecord::Migration[5.0]
  def change
    add_column :information, :email, :string
    add_column :information, :phone, :string
  end
end

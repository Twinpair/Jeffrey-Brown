class CreateInformation < ActiveRecord::Migration[5.0]
  def change
    create_table :information do |t|
      t.string :name
      t.text :about
      t.text :services_description
      t.text :photography_description
      t.text :contact_description
      t.string :header_image

      t.timestamps
    end
  end
end

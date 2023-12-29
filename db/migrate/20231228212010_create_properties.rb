class CreateProperties < ActiveRecord::Migration[7.1]
  def change
    create_table :properties do |t|
      t.integer :property_types, default: 0
      t.float :price, null: false
      t.integer :currencies, default: 0
      t.string :address, null: false
      t.float :area, default: 0
      t.integer :nro_rooms, default: 0
      t.integer :nro_bathrooms, default: 0
      t.text :description, null: false
      t.references :community, null: false, foreign_key: true

      t.timestamps
    end
  end
end

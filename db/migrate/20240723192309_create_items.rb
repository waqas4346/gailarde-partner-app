class CreateItems < ActiveRecord::Migration[7.1]
  def change
    create_table :items do |t|
      t.string :product_name
      t.string :line_item_id
      t.string :sku
      t.integer :quantity
      t.decimal :price, precision: 10, scale: 2
      t.references :order, null: false
      t.timestamps
    end
    add_foreign_key :items, :orders, on_delete: :cascade
  end
end

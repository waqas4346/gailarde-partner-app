class CreateOrders < ActiveRecord::Migration[7.1]
  def change
    create_table :orders do |t|
      t.string :shopify_order_id, null: false
      t.string :status
      t.string :order_number
      t.string :student_id
      t.datetime :order_date
      t.datetime :cancellation_date
      t.decimal :order_value, precision: 10, scale: 2
      t.string :payment_status
      t.string :first_name
      t.string :last_name
      t.string :email
      t.datetime :arrival_date
      t.string :company
      t.text :products
      t.string :address_1
      t.string :address_2
      t.string :zip_code
      t.string :city
      t.string :country
      t.string :cancellation_reason
      t.string :fulfillment_status
      t.string :tracking_number
      t.decimal :total_refunds, precision: 10, scale: 2, default: 0.0
      t.string :currency
      t.references :partner, null: false
      t.references :residence
      t.timestamps
    end
    add_foreign_key :orders, :partners, on_delete: :cascade
    add_foreign_key :orders, :residences, on_delete: :cascade
    add_index :orders, :shopify_order_id, unique: true
  end
end

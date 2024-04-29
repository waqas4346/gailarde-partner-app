class CreateResidences < ActiveRecord::Migration[7.1]
  def change
    create_table :residences do |t|
      t.string :name,              null: false, default: ""
      t.boolean :weekend_delivery,             default: false
      t.integer :pre_arrival_delivery

      t.string :contact_name,              null: false, default: ""
      t.string :contact_email,              null: false, default: ""
      t.string :contact_phone,              null: false, default: ""

      t.string :vehicle_size,              default: ""
      t.boolean :delivery_into_room,  default: false
      t.string :delivery_pickup_location,  default: ""
      t.boolean :delivery_reception, default: false
      t.boolean :manned_reception,  default: false
      t.boolean :no_pallets, default: false
      t.string :delivery_general_info, default: ""
      t.string :what_word_first, default: ""
      t.string :what_word_second, default: ""
      t.string :what_word_third, default: ""

      t.references :partner, null: false
      t.timestamps null: true
    end
    add_foreign_key :residences, :partners, on_delete: :cascade
  end
end

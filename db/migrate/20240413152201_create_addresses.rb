class CreateAddresses < ActiveRecord::Migration[7.1]
  def change
    create_table :addresses do |t|
      t.string :residence_block,              null: false, default: ""
      t.string :address,              null: false, default: ""
      t.string :apartment,              null: false, default: ""
      t.string :city,              null: false, default: ""
      t.string :postcode,              null: false, default: ""
      t.string :country,              null: false, default: ""
      t.references :residence
      t.references :block
      t.references :sub_block
      t.timestamps
    end
    add_foreign_key :addresses, :residences, on_delete: :cascade
    add_foreign_key :addresses, :blocks, on_delete: :cascade
    add_foreign_key :addresses, :sub_blocks, on_delete: :cascade
  end
end

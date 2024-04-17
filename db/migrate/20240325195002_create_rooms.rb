class CreateRooms < ActiveRecord::Migration[7.1]
  def change
    create_table :rooms do |t|
      t.string :name,              null: false, default: ""

      t.references :residence
      t.references :block
      t.references :sub_block
      t.timestamps
    end
    add_foreign_key :rooms, :residences, on_delete: :cascade
    add_foreign_key :rooms, :blocks, on_delete: :cascade
    add_foreign_key :rooms, :sub_blocks, on_delete: :cascade
  end
end

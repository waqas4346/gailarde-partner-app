class CreateSubBlocks < ActiveRecord::Migration[7.1]
  def change
    create_table :sub_blocks do |t|
      t.string :name,              null: false, default: ""
      t.string :what_word_first, default: ""
      t.string :what_word_second, default: ""
      t.string :what_word_third, default: ""
      t.references :block, null: false
      t.timestamps
    end
    add_foreign_key :sub_blocks, :blocks, on_delete: :cascade
  end
end

class CreateShippingCustomMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_custom_messages do |t|
      t.string :title, default: ""
      t.text :message, default: ""
    end
  end
end

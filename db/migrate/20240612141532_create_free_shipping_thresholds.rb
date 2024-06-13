class CreateFreeShippingThresholds < ActiveRecord::Migration[7.1]
  def change
    create_table :free_shipping_thresholds do |t|
      t.decimal :threshhold
      t.text :message, default: ""
    end
  end
end

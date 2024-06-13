class CreateWeekendShippingMethods < ActiveRecord::Migration[7.1]
  def change
    create_table :weekend_shipping_methods do |t|
      t.text :shipping_methods
    end
  end
end

class CreateShippingMethodsWithZipcodes < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_methods_with_zipcodes do |t|
      t.text :shipping_methods
      t.text :zip_codes
    end
  end
end

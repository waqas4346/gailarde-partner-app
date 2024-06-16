class DropShippingCustomMessagesAndHolidays < ActiveRecord::Migration[7.1]
  def change
    def change
      drop_table :shipping_custom_messages, if_exists: true
      drop_table :holidays, if_exists: true
    end
  end
end

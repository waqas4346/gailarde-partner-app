class CreateShippingInfos < ActiveRecord::Migration[7.1]
  def change
    create_table :shipping_infos do |t|
      t.text :shipping_methods
      t.text :info_text
    end
  end
end

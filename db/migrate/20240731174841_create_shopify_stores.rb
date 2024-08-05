class CreateShopifyStores < ActiveRecord::Migration[7.1]
  def change
    create_table :shopify_stores do |t|
      t.string :shop_name
      t.string :access_token

      t.timestamps
    end
  end
end

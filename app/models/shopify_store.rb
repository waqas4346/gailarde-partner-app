# == Schema Information
#
# Table name: shopify_stores
#
#  id           :bigint           not null, primary key
#  access_token :string
#  shop_name    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class ShopifyStore < ApplicationRecord
 
end

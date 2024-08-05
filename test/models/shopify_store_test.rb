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
require "test_helper"

class ShopifyStoreTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

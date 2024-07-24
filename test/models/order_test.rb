# == Schema Information
#
# Table name: orders
#
#  id                 :bigint           not null, primary key
#  address_1          :string
#  address_2          :string
#  city               :string
#  company            :string
#  email              :string
#  first_name         :string
#  fulfillment_status :string
#  last_name          :string
#  order_date         :datetime
#  order_number       :string
#  order_value        :decimal(10, 2)
#  payment_status     :string
#  status             :string
#  tracking_number    :string
#  zip_code           :string
#  created_at         :datetime         not null
#  updated_at         :datetime         not null
#  partner_id         :bigint           not null
#  shopify_order_id   :string           not null
#
# Indexes
#
#  index_orders_on_partner_id        (partner_id)
#  index_orders_on_shopify_order_id  (shopify_order_id) UNIQUE
#
# Foreign Keys
#
#  fk_rails_...  (partner_id => partners.id) ON DELETE => cascade
#
require "test_helper"

class OrderTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

# == Schema Information
#
# Table name: items
#
#  id           :bigint           not null, primary key
#  price        :decimal(10, 2)
#  product_name :string
#  quantity     :integer
#  sku          :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#  line_item_id :string
#  order_id     :bigint           not null
#
# Indexes
#
#  index_items_on_order_id  (order_id)
#
# Foreign Keys
#
#  fk_rails_...  (order_id => orders.id) ON DELETE => cascade
#
require "test_helper"

class ItemTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

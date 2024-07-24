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
class Item < ApplicationRecord
    belongs_to :order
end

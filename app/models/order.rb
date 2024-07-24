# == Schema Information
#
# Table name: orders
#
#  id                  :bigint           not null, primary key
#  address_1           :string
#  address_2           :string
#  cancellation_date   :datetime
#  cancellation_reason :string
#  city                :string
#  company             :string
#  country             :string
#  currency            :string
#  email               :string
#  first_name          :string
#  fulfillment_status  :string
#  last_name           :string
#  order_date          :datetime
#  order_number        :string
#  order_value         :decimal(10, 2)
#  payment_status      :string
#  status              :string
#  total_refunds       :decimal(10, 2)   default(0.0)
#  tracking_number     :string
#  zip_code            :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#  partner_id          :bigint           not null
#  shopify_order_id    :string           not null
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
class Order < ApplicationRecord
    belongs_to :partner
    has_many :items, dependent: :destroy

    validates :shopify_order_id, uniqueness: true

   
    def self.ransackable_associations(auth_object = nil)
        %w[partner]
    end

    def self.ransackable_attributes(auth_object = nil)
        %w[shopify_order_id status order_number order_date order_value payment_status first_name last_name email company address_1 address_2 zip_code city fulfillment_status tracking_number]
    end
end

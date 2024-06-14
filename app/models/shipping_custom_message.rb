# == Schema Information
#
# Table name: shipping_custom_messages
#
#  id      :bigint           not null, primary key
#  message :text             default("")
#  title   :string           default("")
#
class ShippingCustomMessage < ApplicationRecord
end

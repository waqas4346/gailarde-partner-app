# == Schema Information
#
# Table name: shipping_infos
#
#  id               :bigint           not null, primary key
#  info_text        :text
#  shipping_methods :text
#
class ShippingInfo < ApplicationRecord
end

# == Schema Information
#
# Table name: shipping_methods_with_zipcodes
#
#  id               :bigint           not null, primary key
#  shipping_methods :text
#  zip_codes        :text
#
class ShippingMethodsWithZipcode < ApplicationRecord
end

# == Schema Information
#
# Table name: partners
#
#  id                                :bigint           not null, primary key
#  active                            :boolean          default(TRUE)
#  banner                            :boolean          default(FALSE)
#  banner_info                       :text             default("")
#  beds                              :integer          default(0)
#  checkout                          :boolean          default(FALSE)
#  checkout_info                     :text             default("")
#  commission                        :decimal(10, 2)   default(0.0)
#  consolidated_email                :string           default("")
#  consolidated_name                 :string           default("")
#  consolidated_number               :string           default("")
#  contact_email                     :string           default(""), not null
#  contact_number                    :string           default(""), not null
#  customer_group                    :string           default("")
#  discount_code                     :string           default("")
#  discount_code_value               :string           default("")
#  extra_internal_info               :text             default("")
#  international_students_percentage :decimal(10, 2)   default(0.0)
#  landing_page                      :string           default("")
#  logo                              :string           default("")
#  main_intake_date                  :datetime
#  name                              :string           default(""), not null
#  order_info_level                  :string
#  parameter                         :string           default(""), not null
#  previous_year_uptake              :decimal(10, 2)   default(0.0)
#  show_fulfillment                  :boolean          default(TRUE)
#  show_tracking_number              :boolean          default(TRUE)
#  students                          :integer          default(0)
#  working_hours                     :text             default("")
#  created_at                        :datetime
#  updated_at                        :datetime
#  hub_spot_id                       :string           default("")
#
class Partner < ApplicationRecord
  has_many :users, dependent: :destroy

  has_many :residences, dependent: :destroy
  has_many :orders, dependent: :destroy


  def self.ransackable_attributes(auth_object = nil)
    ["admin_user_id", "created_at", "description", "id", "id_value", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["admin_user"]
  end
end

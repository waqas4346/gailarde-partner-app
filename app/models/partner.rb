# == Schema Information
#
# Table name: partners
#
#  id                                :bigint           not null, primary key
#  banner                            :boolean          default(FALSE), not null
#  banner_info                       :text             default(""), not null
#  beds                              :integer          default(0), not null
#  checkout                          :boolean          default(FALSE), not null
#  checkout_info                     :text             default(""), not null
#  commission                        :decimal(10, 2)   default(0.0), not null
#  consolidated_email                :string           default("")
#  consolidated_name                 :string           default("")
#  consolidated_number               :string           default("")
#  contact_email                     :string           default("")
#  contact_number                    :string           default("")
#  customer_group                    :string           default(""), not null
#  discount_code                     :boolean          default(FALSE), not null
#  discount_code_value               :string           default(""), not null
#  extra_internal_info               :text             default(""), not null
#  international_students_percentage :decimal(10, 2)   default(0.0), not null
#  landing_page                      :string           default(""), not null
#  logo                              :string           default(""), not null
#  main_intake_date                  :datetime
#  name                              :string           default(""), not null
#  order_info_level                  :string           not null
#  parameter                         :string           default(""), not null
#  previous_year_uptake              :decimal(10, 2)   default(0.0), not null
#  students                          :integer          default(0), not null
#  working_hours                     :text             default(""), not null
#  created_at                        :datetime
#  updated_at                        :datetime
#  hub_spot_id                       :string           default(""), not null
#
class Partner < ApplicationRecord
  has_many :users, dependent: :destroy

  has_one :residence, dependent: :destroy


  def self.ransackable_attributes(auth_object = nil)
    ["admin_user_id", "created_at", "description", "id", "id_value", "name", "updated_at"]
  end

  def self.ransackable_associations(auth_object = nil)
    ["admin_user"]
  end
end

# == Schema Information
#
# Table name: week_days_times
#
#  id                         :bigint           not null, primary key
#  custom_message_description :text             default("")
#  custom_message_title       :string           default("")
#  friday_cuttoff_time        :string
#  friday_lead_time           :integer
#  holidays                   :text             default("")
#  message                    :text             default("")
#  monday_cuttoff_time        :string
#  monday_lead_time           :integer
#  saturday_cuttoff_time      :string
#  saturday_lead_time         :integer
#  sunday_cuttoff_time        :string
#  sunday_lead_time           :integer
#  threshold                  :decimal(, )
#  threshold_title            :string           default("")
#  thursday_cuttoff_time      :string
#  thursday_lead_time         :integer
#  tuesday_cuttoff_time       :string
#  tuesday_lead_time          :integer
#  wednesday_cuttoff_time     :string
#  wednesday_lead_time        :integer
#  weekend_available          :boolean          default(FALSE)
#
class WeekDaysTime < ApplicationRecord
end

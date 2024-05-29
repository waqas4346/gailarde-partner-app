# == Schema Information
#
# Table name: week_days_times
#
#  id                     :bigint           not null, primary key
#  friday_cuttoff_time    :datetime
#  friday_lead_time       :integer
#  monday_cuttoff_time    :datetime
#  monday_lead_time       :integer
#  saturday_cuttoff_time  :datetime
#  saturday_lead_time     :integer
#  sunday_cuttoff_time    :datetime
#  sunday_lead_time       :integer
#  thursday_cuttoff_time  :datetime
#  thursday_lead_time     :integer
#  tuesday_cuttoff_time   :datetime
#  tuesday_lead_time      :integer
#  wednesday_cuttoff_time :datetime
#  wednesday_lead_time    :integer
#
class WeekDaysTime < ApplicationRecord
end

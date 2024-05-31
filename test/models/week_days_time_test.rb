# == Schema Information
#
# Table name: week_days_times
#
#  id                     :bigint           not null, primary key
#  friday_cuttoff_time    :string
#  friday_lead_time       :integer
#  monday_cuttoff_time    :string
#  monday_lead_time       :integer
#  saturday_cuttoff_time  :string
#  saturday_lead_time     :integer
#  sunday_cuttoff_time    :string
#  sunday_lead_time       :integer
#  thursday_cuttoff_time  :string
#  thursday_lead_time     :integer
#  tuesday_cuttoff_time   :string
#  tuesday_lead_time      :integer
#  wednesday_cuttoff_time :string
#  wednesday_lead_time    :integer
#
require "test_helper"

class WeekDaysTimeTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

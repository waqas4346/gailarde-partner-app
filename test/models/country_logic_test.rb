# == Schema Information
#
# Table name: country_logics
#
#  id                :bigint           not null, primary key
#  countries         :text
#  country_lead_time :integer
#  weekend_available :boolean          default(FALSE)
#
require "test_helper"

class CountryLogicTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end
end

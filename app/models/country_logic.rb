# == Schema Information
#
# Table name: country_logics
#
#  id                :bigint           not null, primary key
#  countries         :text
#  country_lead_time :integer
#  weekend_available :boolean          default(FALSE)
#
class CountryLogic < ApplicationRecord
end

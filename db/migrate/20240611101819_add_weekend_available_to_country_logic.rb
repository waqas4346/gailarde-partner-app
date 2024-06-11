class AddWeekendAvailableToCountryLogic < ActiveRecord::Migration[7.1]
  def change
    add_column :country_logics, :weekend_available, :boolean, default: false
  end
end

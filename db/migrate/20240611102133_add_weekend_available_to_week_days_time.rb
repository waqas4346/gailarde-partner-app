class AddWeekendAvailableToWeekDaysTime < ActiveRecord::Migration[7.1]
  def change
    add_column :week_days_times, :weekend_available, :boolean, default: false
  end
end

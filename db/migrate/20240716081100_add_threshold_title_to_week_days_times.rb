class AddThresholdTitleToWeekDaysTimes < ActiveRecord::Migration[7.1]
  def change
    add_column :week_days_times, :threshold_title, :string, default: ""
  end
end

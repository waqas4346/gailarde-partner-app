class ChangeCutoffTimeColumnsToString < ActiveRecord::Migration[7.1]
  def up
    change_column :week_days_times, :monday_cuttoff_time, :string
    change_column :week_days_times, :tuesday_cuttoff_time, :string
    change_column :week_days_times, :wednesday_cuttoff_time, :string
    change_column :week_days_times, :thursday_cuttoff_time, :string
    change_column :week_days_times, :friday_cuttoff_time, :string
    change_column :week_days_times, :saturday_cuttoff_time, :string
    change_column :week_days_times, :sunday_cuttoff_time, :string
  end

  def down
    change_column :week_days_times, :monday_cuttoff_time, :datetime
    change_column :week_days_times, :tuesday_cuttoff_time, :datetime
    change_column :week_days_times, :wednesday_cuttoff_time, :datetime
    change_column :week_days_times, :thursday_cuttoff_time, :datetime
    change_column :week_days_times, :friday_cuttoff_time, :datetime
    change_column :week_days_times, :saturday_cuttoff_time, :datetime
    change_column :week_days_times, :sunday_cuttoff_time, :datetime
  end
end

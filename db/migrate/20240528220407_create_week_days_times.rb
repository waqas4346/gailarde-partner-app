class CreateWeekDaysTimes < ActiveRecord::Migration[7.1]
  def change
    create_table :week_days_times do |t|
      t.datetime :monday_cuttoff_time
      t.datetime :tuesday_cuttoff_time
      t.datetime :wednesday_cuttoff_time
      t.datetime :thursday_cuttoff_time
      t.datetime :friday_cuttoff_time
      t.datetime :saturday_cuttoff_time
      t.datetime :sunday_cuttoff_time
      t.integer :monday_lead_time
      t.integer :tuesday_lead_time
      t.integer :wednesday_lead_time
      t.integer :thursday_lead_time
      t.integer :friday_lead_time
      t.integer :saturday_lead_time
      t.integer :sunday_lead_time
    end
  end
end

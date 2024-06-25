class UpdateWeekDaysTimes < ActiveRecord::Migration[7.1]
  def change
    # Adding fields to week_days_times table
    add_column :week_days_times, :threshold, :decimal
    add_column :week_days_times, :message, :text, default: ""

    # Dropping the free_shipping_thresholds table
    drop_table :free_shipping_thresholds do |t|
      t.decimal :threshold
      t.text :message, default: ""
    end
  end
end

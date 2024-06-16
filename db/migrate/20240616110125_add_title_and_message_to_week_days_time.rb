class AddTitleAndMessageToWeekDaysTime < ActiveRecord::Migration[7.1]
  def change
    add_column :week_days_times, :custom_message_title, :string, default: ""
    add_column :week_days_times, :custom_message_description, :text, default: ""
    add_column :week_days_times, :holidays, :text, default: ""
  end
end

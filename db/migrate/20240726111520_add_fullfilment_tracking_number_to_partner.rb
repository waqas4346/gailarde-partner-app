class AddFullfilmentTrackingNumberToPartner < ActiveRecord::Migration[7.1]
  def change
    add_column :partners, :show_fulfillment, :boolean, default: true
    add_column :partners, :show_tracking_number, :boolean, default: true
  end
end

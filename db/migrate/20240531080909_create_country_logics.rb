class CreateCountryLogics < ActiveRecord::Migration[7.1]
  def change
    create_table :country_logics do |t|
      t.integer :country_lead_time
      t.text :countries
    end
  end
end

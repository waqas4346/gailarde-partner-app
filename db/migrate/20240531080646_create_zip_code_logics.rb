class CreateZipCodeLogics < ActiveRecord::Migration[7.1]
  def change
    create_table :zip_code_logics do |t|
      t.integer :zip_code_lead_time
      t.text :zip_codes_start
    end
  end
end

class CreateZipCodeLogics < ActiveRecord::Migration[7.1]
  def change
    create_table :zip_code_logics do |t|

      t.timestamps
    end
  end
end

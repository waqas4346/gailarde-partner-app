class CreatePartners < ActiveRecord::Migration[7.1]
  def change
    create_table :partners do |t|
      t.string :name,              null: false, default: ""
      t.string :parameter,              null: false, default: ""
      t.string :logo,              null: false, default: ""
      t.string :customer_group,             null: false, default: "" #enum
      t.decimal :commission, precision: 10, scale: 2, null: false, default: 0.0
      t.string :contact_email,             default: ""
      t.string :contact_number,            default: ""              
      t.text :working_hours,              null: false, default: ""

      t.string :consolidated_name,               default: ""
      t.string :consolidated_email,              default: ""
      t.string :consolidated_number,             default: ""

      t.integer :beds,             null: false, default: 0
      t.integer :students,             null: false, default: 0
      t.decimal :previous_year_uptake, precision: 10, scale: 2, null: false, default: 0.0
      t.decimal :international_students_percentage, precision: 10, scale: 2, null: false, default: 0.0

      t.text :extra_internal_info,              null: false, default: ""

      t.boolean :banner, null: false, default: false
      t.text :banner_info,              null: false, default: ""
      t.boolean :checkout, null: false, default: false
      t.text :checkout_info,              null: false, default: ""

      t.string :landing_page,              null: false, default: ""
      t.string :hub_spot_id,              null: false, default: ""
      t.datetime :main_intake_date

      t.boolean :discount_code, null: false, default: false
      t.string :discount_code_value, null: false, default: ""
      t.string :order_info_level,             null: false

      
      
      t.timestamps null: true
    end
  end
end

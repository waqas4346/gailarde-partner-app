class CreatePartners < ActiveRecord::Migration[7.1]
  def change
    create_table :partners do |t|
      t.string :name,              null: false, default: ""
      t.string :parameter,           null: false,    default: ""
      t.string :logo,               default: ""
      t.string :customer_group,              default: "" #enum
      t.decimal :commission, precision: 10, scale: 2,  default: 0.0
      t.string :contact_email,       null: false,      default: ""
      t.string :contact_number,      null: false,      default: ""              
      t.text :working_hours,               default: ""

      t.string :consolidated_name,               default: ""
      t.string :consolidated_email,              default: ""
      t.string :consolidated_number,             default: ""

      t.integer :beds,              default: 0
      t.integer :students,              default: 0
      t.decimal :previous_year_uptake, precision: 10, scale: 2,  default: 0.0
      t.decimal :international_students_percentage, precision: 10, scale: 2,  default: 0.0

      t.text :extra_internal_info,               default: ""

      t.boolean :banner,  default: false
      t.text :banner_info,               default: ""
      t.boolean :checkout,  default: false
      t.text :checkout_info,               default: ""

      t.string :landing_page,               default: ""
      t.string :hub_spot_id,               default: ""
      t.datetime :main_intake_date

      t.boolean :discount_code,  default: false
      t.string :discount_code_value,  default: ""
      t.string :order_info_level

      
      
      t.timestamps null: true
    end
  end
end

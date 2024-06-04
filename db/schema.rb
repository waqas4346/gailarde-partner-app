# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_05_31_081145) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "what_word_first", default: ""
    t.string "what_word_second", default: ""
    t.string "what_word_third", default: ""
    t.boolean "active", default: true
    t.string "residence_block", default: ""
    t.string "address", default: ""
    t.string "apartment", default: ""
    t.string "city", default: ""
    t.string "postcode", default: ""
    t.string "country", default: ""
    t.bigint "residence_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["residence_id"], name: "index_blocks_on_residence_id"
  end

  create_table "country_logics", force: :cascade do |t|
    t.integer "country_lead_time"
    t.text "countries"
  end

  create_table "holidays", force: :cascade do |t|
    t.text "days"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "parameter", default: "", null: false
    t.string "logo", default: ""
    t.string "customer_group", default: ""
    t.decimal "commission", precision: 10, scale: 2, default: "0.0"
    t.string "contact_email", default: "", null: false
    t.string "contact_number", default: "", null: false
    t.text "working_hours", default: ""
    t.string "consolidated_name", default: ""
    t.string "consolidated_email", default: ""
    t.string "consolidated_number", default: ""
    t.integer "beds", default: 0
    t.integer "students", default: 0
    t.decimal "previous_year_uptake", precision: 10, scale: 2, default: "0.0"
    t.decimal "international_students_percentage", precision: 10, scale: 2, default: "0.0"
    t.text "extra_internal_info", default: ""
    t.boolean "banner", default: false
    t.text "banner_info", default: ""
    t.boolean "checkout", default: false
    t.text "checkout_info", default: ""
    t.string "landing_page", default: ""
    t.string "hub_spot_id", default: ""
    t.datetime "main_intake_date"
    t.boolean "discount_code", default: false
    t.boolean "active", default: true
    t.string "discount_code_value", default: ""
    t.string "order_info_level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "residences", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "weekend_delivery", default: false
    t.integer "pre_arrival_delivery"
    t.string "contact_name", default: "", null: false
    t.string "contact_email", default: "", null: false
    t.string "contact_phone", default: "", null: false
    t.string "vehicle_size", default: ""
    t.boolean "delivery_into_room", default: false
    t.string "delivery_pickup_location", default: ""
    t.boolean "delivery_reception", default: false
    t.boolean "manned_reception", default: false
    t.boolean "no_pallets", default: false
    t.text "delivery_general_info", default: ""
    t.string "what_word_first", default: ""
    t.string "what_word_second", default: ""
    t.string "what_word_third", default: ""
    t.boolean "active", default: true
    t.string "residence_block", default: ""
    t.string "address", default: ""
    t.string "apartment", default: ""
    t.string "city", default: ""
    t.string "postcode", default: ""
    t.string "country", default: ""
    t.bigint "partner_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["partner_id"], name: "index_residences_on_partner_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "residence_id"
    t.bigint "block_id"
    t.bigint "sub_block_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["block_id"], name: "index_rooms_on_block_id"
    t.index ["residence_id"], name: "index_rooms_on_residence_id"
    t.index ["sub_block_id"], name: "index_rooms_on_sub_block_id"
  end

  create_table "sub_blocks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "what_word_first", default: ""
    t.string "what_word_second", default: ""
    t.string "what_word_third", default: ""
    t.boolean "active", default: true
    t.string "residence_block", default: ""
    t.string "address", default: ""
    t.string "apartment", default: ""
    t.string "city", default: ""
    t.string "postcode", default: ""
    t.string "country", default: ""
    t.bigint "block_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["block_id"], name: "index_sub_blocks_on_block_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.text "position", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.text "info_field_internal", default: ""
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "partner_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["partner_id"], name: "index_users_on_partner_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "week_days_times", force: :cascade do |t|
    t.string "monday_cuttoff_time"
    t.string "tuesday_cuttoff_time"
    t.string "wednesday_cuttoff_time"
    t.string "thursday_cuttoff_time"
    t.string "friday_cuttoff_time"
    t.string "saturday_cuttoff_time"
    t.string "sunday_cuttoff_time"
    t.integer "monday_lead_time"
    t.integer "tuesday_lead_time"
    t.integer "wednesday_lead_time"
    t.integer "thursday_lead_time"
    t.integer "friday_lead_time"
    t.integer "saturday_lead_time"
    t.integer "sunday_lead_time"
  end

  create_table "zip_code_logics", force: :cascade do |t|
    t.integer "zip_code_lead_time"
    t.text "zip_codes_start"
  end

  add_foreign_key "blocks", "residences", on_delete: :cascade
  add_foreign_key "residences", "partners", on_delete: :cascade
  add_foreign_key "rooms", "blocks", on_delete: :cascade
  add_foreign_key "rooms", "residences", on_delete: :cascade
  add_foreign_key "rooms", "sub_blocks", on_delete: :cascade
  add_foreign_key "sub_blocks", "blocks", on_delete: :cascade
  add_foreign_key "users", "partners", on_delete: :cascade
end

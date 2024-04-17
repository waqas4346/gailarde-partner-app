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

ActiveRecord::Schema[7.1].define(version: 2024_04_13_152201) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "addresses", force: :cascade do |t|
    t.string "residence_block", default: "", null: false
    t.string "address", default: "", null: false
    t.string "apartment", default: "", null: false
    t.string "city", default: "", null: false
    t.string "postcode", default: "", null: false
    t.string "country", default: "", null: false
    t.bigint "residence_id"
    t.bigint "block_id"
    t.bigint "sub_block_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_addresses_on_block_id"
    t.index ["residence_id"], name: "index_addresses_on_residence_id"
    t.index ["sub_block_id"], name: "index_addresses_on_sub_block_id"
  end

  create_table "blocks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "what_word_first", default: ""
    t.string "what_word_second", default: ""
    t.string "what_word_third", default: ""
    t.bigint "residence_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["residence_id"], name: "index_blocks_on_residence_id"
  end

  create_table "partners", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "parameter", default: "", null: false
    t.string "logo", default: "", null: false
    t.string "customer_group", default: "", null: false
    t.decimal "commission", precision: 10, scale: 2, default: "0.0", null: false
    t.string "contact_email", default: ""
    t.string "contact_number", default: ""
    t.text "working_hours", default: "", null: false
    t.string "consolidated_name", default: ""
    t.string "consolidated_email", default: ""
    t.string "consolidated_number", default: ""
    t.integer "beds", default: 0, null: false
    t.integer "students", default: 0, null: false
    t.decimal "previous_year_uptake", precision: 10, scale: 2, default: "0.0", null: false
    t.decimal "international_students_percentage", precision: 10, scale: 2, default: "0.0", null: false
    t.text "extra_internal_info", default: "", null: false
    t.boolean "banner", default: false, null: false
    t.text "banner_info", default: "", null: false
    t.boolean "checkout", default: false, null: false
    t.text "checkout_info", default: "", null: false
    t.string "landing_page", default: "", null: false
    t.string "hub_spot_id", default: "", null: false
    t.datetime "main_intake_date"
    t.boolean "discount_code", default: false, null: false
    t.string "discount_code_value", default: "", null: false
    t.string "order_info_level", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "residences", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.boolean "weekend_delivery", default: false, null: false
    t.integer "pre_arrival_delivery"
    t.string "contact_name", default: "", null: false
    t.string "contact_email", default: "", null: false
    t.string "contact_phone", default: "", null: false
    t.string "vehicle_size", default: "", null: false
    t.boolean "delivery_into_room", default: false, null: false
    t.string "delivery_pickup_location", default: "", null: false
    t.boolean "delivery_reception", default: false, null: false
    t.boolean "no_pallets", default: false, null: false
    t.string "delivery_general_info", default: "", null: false
    t.string "what_word_first", default: ""
    t.string "what_word_second", default: ""
    t.string "what_word_third", default: ""
    t.bigint "partner_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["partner_id"], name: "index_residences_on_partner_id"
  end

  create_table "rooms", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.bigint "residence_id"
    t.bigint "block_id"
    t.bigint "sub_block_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_rooms_on_block_id"
    t.index ["residence_id"], name: "index_rooms_on_residence_id"
    t.index ["sub_block_id"], name: "index_rooms_on_sub_block_id"
  end

  create_table "sub_blocks", force: :cascade do |t|
    t.string "name", default: "", null: false
    t.string "what_word_first", default: ""
    t.string "what_word_second", default: ""
    t.string "what_word_third", default: ""
    t.bigint "block_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["block_id"], name: "index_sub_blocks_on_block_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "role", default: "admin_partner", null: false
    t.string "first_name", default: "", null: false
    t.string "last_name", default: "", null: false
    t.string "position", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "partner_id", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["partner_id"], name: "index_users_on_partner_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "addresses", "blocks", on_delete: :cascade
  add_foreign_key "addresses", "residences", on_delete: :cascade
  add_foreign_key "addresses", "sub_blocks", on_delete: :cascade
  add_foreign_key "blocks", "residences", on_delete: :cascade
  add_foreign_key "residences", "partners", on_delete: :cascade
  add_foreign_key "rooms", "blocks", on_delete: :cascade
  add_foreign_key "rooms", "residences", on_delete: :cascade
  add_foreign_key "rooms", "sub_blocks", on_delete: :cascade
  add_foreign_key "sub_blocks", "blocks", on_delete: :cascade
  add_foreign_key "users", "partners", on_delete: :cascade
end

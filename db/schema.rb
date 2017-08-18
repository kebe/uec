# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 20170817191233) do

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
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "clients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "medicaid_number"
    t.string "address"
    t.string "site"
    t.boolean "disability"
    t.bigint "route_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contract_id"
    t.string "goodwill_account_type"
    t.string "client_type"
    t.decimal "medical_miles"
    t.decimal "non_medical_miles"
    t.boolean "m_pickup"
    t.boolean "t_pickup"
    t.boolean "w_pickup"
    t.boolean "r_pickup"
    t.boolean "f_pickup"
    t.boolean "m_dropoff"
    t.boolean "t_dropoff"
    t.boolean "w_dropoff"
    t.boolean "r_dropoff"
    t.boolean "f_dropoff"
    t.boolean "active"
    t.decimal "escort_hours"
    t.index ["contract_id"], name: "index_clients_on_contract_id"
    t.index ["route_id"], name: "index_clients_on_route_id"
  end

  create_table "contracts", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "contact_name"
    t.string "phone_number"
    t.boolean "active"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "drivers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "first_name"
    t.string "last_name"
    t.boolean "active"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "worksheet"
    t.index ["email"], name: "index_drivers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_drivers_on_reset_password_token", unique: true
  end

  create_table "operations", force: :cascade do |t|
    t.string "op_type"
    t.datetime "time"
    t.bigint "client_id"
    t.bigint "driver_id"
    t.string "status"
    t.string "helper"
    t.boolean "wheelchair"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["client_id"], name: "index_operations_on_client_id"
    t.index ["driver_id"], name: "index_operations_on_driver_id"
  end

  create_table "route_trips", force: :cascade do |t|
    t.bigint "route_id"
    t.string "trip_type"
    t.string "assistant"
    t.decimal "starting_miles"
    t.decimal "ending_miles"
    t.string "lic_plate"
    t.time "finish_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["route_id"], name: "index_route_trips_on_route_id"
  end

  create_table "routes", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "contract_id"
    t.bigint "driver_id"
    t.index ["contract_id"], name: "index_routes_on_contract_id"
    t.index ["driver_id"], name: "index_routes_on_driver_id"
  end

  create_table "service_tickets", force: :cascade do |t|
    t.bigint "client_id"
    t.bigint "driver_id"
    t.date "service_date"
    t.time "service_time"
    t.string "pickup_address"
    t.string "dropoff_address"
    t.string "pickup_time"
    t.string "dropoff_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "mileage"
    t.string "from_zipcode"
    t.string "to_zipcode"
    t.boolean "override"
    t.index ["client_id"], name: "index_service_tickets_on_client_id"
    t.index ["driver_id"], name: "index_service_tickets_on_driver_id"
  end

  create_table "zipcode_mappings", force: :cascade do |t|
    t.string "start_zip"
    t.string "end_zip"
    t.string "mileage"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "clients", "routes"
  add_foreign_key "operations", "clients"
  add_foreign_key "operations", "drivers"
  add_foreign_key "route_trips", "routes"
  add_foreign_key "service_tickets", "clients"
  add_foreign_key "service_tickets", "drivers"
end

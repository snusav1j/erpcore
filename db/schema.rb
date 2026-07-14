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

ActiveRecord::Schema[8.0].define(version: 2026_07_14_221353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "client_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.string "color"
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "name"], name: "index_client_statuses_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_client_statuses_on_company_id"
  end

  create_table "client_types", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["company_id", "name"], name: "index_client_types_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_client_types_on_company_id"
  end

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.bigint "company_id", null: false
    t.bigint "client_type_id"
    t.bigint "client_status_id"
    t.index ["client_status_id"], name: "index_clients_on_client_status_id"
    t.index ["client_type_id"], name: "index_clients_on_client_type_id"
    t.index ["company_id"], name: "index_clients_on_company_id"
    t.index ["manager_id"], name: "index_clients_on_manager_id"
    t.index ["phone"], name: "index_clients_on_phone"
  end

  create_table "companies", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.boolean "active", default: true, null: false
    t.datetime "paid_until"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["active"], name: "index_companies_on_active"
    t.index ["manager_id"], name: "index_companies_on_manager_id"
    t.index ["slug"], name: "index_companies_on_slug", unique: true
  end

  create_table "custom_field_values", force: :cascade do |t|
    t.bigint "custom_field_id", null: false
    t.string "entity_type", null: false
    t.bigint "entity_id", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_custom_field_values_on_company_id"
    t.index ["custom_field_id"], name: "index_custom_field_values_on_custom_field_id"
    t.index ["entity_type", "entity_id"], name: "index_custom_field_values_on_entity"
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string "entity", null: false
    t.string "key", null: false
    t.string "label", null: false
    t.string "field_type", null: false
    t.boolean "required", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id", "entity", "key"], name: "index_custom_fields_on_company_id_and_entity_and_key", unique: true
    t.index ["company_id"], name: "index_custom_fields_on_company_id"
  end

  create_table "interaction_statuses", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["company_id", "name"], name: "index_interaction_statuses_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_interaction_statuses_on_company_id"
  end

  create_table "interaction_types", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "company_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "color"
    t.index ["company_id", "name"], name: "index_interaction_types_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_interaction_types_on_company_id"
  end

  create_table "interactions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.bigint "company_id"
    t.bigint "interaction_type_id"
    t.bigint "interaction_status_id"
    t.index ["client_id"], name: "index_interactions_on_client_id"
    t.index ["company_id"], name: "index_interactions_on_company_id"
    t.index ["interaction_status_id"], name: "index_interactions_on_interaction_status_id"
    t.index ["interaction_type_id"], name: "index_interactions_on_interaction_type_id"
    t.index ["manager_id"], name: "index_interactions_on_manager_id"
  end

  create_table "order_items", force: :cascade do |t|
    t.bigint "order_id", null: false
    t.bigint "product_id", null: false
    t.decimal "price", precision: 12, scale: 2
    t.integer "quantity", default: 1
    t.decimal "total", precision: 12, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id"], name: "index_order_items_on_company_id"
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "order_statuses", force: :cascade do |t|
    t.bigint "company_id", null: false
    t.string "name", null: false
    t.string "color"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["company_id", "name"], name: "index_order_statuses_on_company_id_and_name", unique: true
    t.index ["company_id"], name: "index_order_statuses_on_company_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.decimal "final_price", precision: 12, scale: 2
    t.text "comment"
    t.bigint "company_id"
    t.bigint "order_status_id"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["company_id"], name: "index_orders_on_company_id"
    t.index ["manager_id"], name: "index_orders_on_manager_id"
    t.index ["order_status_id"], name: "index_orders_on_order_status_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.boolean "in_stock"
    t.text "comment"
    t.bigint "company_id"
    t.index ["company_id"], name: "index_products_on_company_id"
    t.index ["manager_id"], name: "index_products_on_manager_id"
  end

  create_table "table_settings", force: :cascade do |t|
    t.string "entity", null: false
    t.string "column_key", null: false
    t.integer "position", default: 0, null: false
    t.boolean "visible", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "company_id"
    t.index ["company_id", "entity", "column_key"], name: "index_table_settings_on_company_id_and_entity_and_column_key", unique: true
    t.index ["company_id"], name: "index_table_settings_on_company_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "hide_sidebar", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "column_visibility_block_state"
    t.boolean "custom_fields_block_state"
    t.index ["user_id"], name: "index_user_settings_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "role"
    t.bigint "company_id"
    t.boolean "banned", default: false, null: false
    t.string "last_name"
    t.string "first_name"
    t.string "middle_name"
    t.date "birthday"
    t.string "phone"
    t.string "telegram"
    t.bigint "telegram_chat_id"
    t.index ["banned"], name: "index_users_on_banned"
    t.index ["company_id"], name: "index_users_on_company_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["phone"], name: "index_users_on_phone"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
    t.index ["telegram"], name: "index_users_on_telegram"
    t.index ["telegram_chat_id"], name: "index_users_on_telegram_chat_id"
  end

  add_foreign_key "client_statuses", "companies"
  add_foreign_key "client_types", "companies"
  add_foreign_key "clients", "client_statuses"
  add_foreign_key "clients", "client_types"
  add_foreign_key "clients", "companies"
  add_foreign_key "companies", "users", column: "manager_id"
  add_foreign_key "custom_field_values", "companies"
  add_foreign_key "custom_field_values", "custom_fields"
  add_foreign_key "custom_fields", "companies"
  add_foreign_key "interaction_statuses", "companies"
  add_foreign_key "interaction_types", "companies"
  add_foreign_key "interactions", "clients"
  add_foreign_key "interactions", "companies"
  add_foreign_key "interactions", "interaction_statuses"
  add_foreign_key "interactions", "interaction_types"
  add_foreign_key "order_items", "companies"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "order_statuses", "companies"
  add_foreign_key "orders", "clients"
  add_foreign_key "orders", "companies"
  add_foreign_key "orders", "order_statuses"
  add_foreign_key "products", "companies"
  add_foreign_key "table_settings", "companies"
  add_foreign_key "users", "companies"
end

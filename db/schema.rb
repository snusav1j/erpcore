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

ActiveRecord::Schema[8.0].define(version: 2026_07_10_181512) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "clients", force: :cascade do |t|
    t.string "name"
    t.string "phone"
    t.string "email"
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.integer "client_type"
    t.integer "status", default: 1, null: false
    t.index ["client_type"], name: "index_clients_on_client_type"
    t.index ["manager_id"], name: "index_clients_on_manager_id"
    t.index ["phone"], name: "index_clients_on_phone"
  end

  create_table "custom_field_values", force: :cascade do |t|
    t.bigint "custom_field_id", null: false
    t.string "entity", null: false
    t.bigint "entity_id", null: false
    t.text "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_field_id"], name: "index_custom_field_values_on_custom_field_id"
    t.index ["entity", "entity_id"], name: "index_custom_field_values_on_entity_and_entity_id"
  end

  create_table "custom_fields", force: :cascade do |t|
    t.string "entity", null: false
    t.string "code", null: false
    t.string "label", null: false
    t.string "field_type", null: false
    t.boolean "required", default: false
    t.integer "position", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["entity", "code"], name: "index_custom_fields_on_entity_and_code", unique: true
  end

  create_table "interactions", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "interaction_type"
    t.string "status", default: "new"
    t.text "comment"
    t.datetime "occurred_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.index ["client_id"], name: "index_interactions_on_client_id"
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
    t.index ["order_id"], name: "index_order_items_on_order_id"
    t.index ["product_id"], name: "index_order_items_on_product_id"
  end

  create_table "orders", force: :cascade do |t|
    t.bigint "client_id", null: false
    t.string "status", default: "new"
    t.datetime "closed_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "manager_id"
    t.decimal "final_price", precision: 12, scale: 2
    t.text "comment"
    t.index ["client_id"], name: "index_orders_on_client_id"
    t.index ["manager_id"], name: "index_orders_on_manager_id"
  end

  create_table "products", force: :cascade do |t|
    t.string "name", null: false
    t.string "sku"
    t.bigint "manager_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "price"
    t.boolean "in_stock"
    t.text "comment"
    t.index ["manager_id"], name: "index_products_on_manager_id"
  end

  create_table "user_settings", force: :cascade do |t|
    t.integer "user_id"
    t.boolean "hide_sidebar", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["role"], name: "index_users_on_role"
  end

  add_foreign_key "custom_field_values", "custom_fields"
  add_foreign_key "interactions", "clients"
  add_foreign_key "order_items", "orders"
  add_foreign_key "order_items", "products"
  add_foreign_key "orders", "clients"
end

# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160622160014) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "cat_products", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "catalogue_id"
    t.uuid     "product_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "cat_products", ["catalogue_id", "product_id"], name: "index_cat_products_on_catalogue_id_and_product_id", unique: true, using: :btree
  add_index "cat_products", ["catalogue_id"], name: "index_cat_products_on_catalogue_id", using: :btree
  add_index "cat_products", ["product_id"], name: "index_cat_products_on_product_id", using: :btree

  create_table "catalogues", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.uuid     "parent_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "order_items", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "product_id"
    t.uuid     "order_id"
    t.integer  "unit_price"
    t.integer  "quantity"
    t.integer  "total_price"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "order_items", ["order_id"], name: "index_order_items_on_order_id", using: :btree
  add_index "order_items", ["product_id", "order_id"], name: "index_order_items_on_product_id_and_order_id", unique: true, using: :btree
  add_index "order_items", ["product_id"], name: "index_order_items_on_product_id", using: :btree

  create_table "order_statuses", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "orders", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "subtotal"
    t.string   "tax"
    t.string   "shipping"
    t.integer  "total"
    t.uuid     "order_status_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "orders", ["order_status_id"], name: "index_orders_on_order_status_id", using: :btree

  create_table "products", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.integer  "price"
    t.integer  "quantity"
    t.boolean  "active",      default: true
    t.string   "picture"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "users", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.string   "remember_digest"
    t.boolean  "admin",           default: false
    t.string   "reset_digest"
    t.datetime "reset_send_at"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  create_table "watchings", id: :uuid, default: "uuid_generate_v4()", force: :cascade do |t|
    t.uuid     "product_id"
    t.uuid     "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "watchings", ["product_id", "user_id"], name: "index_watchings_on_product_id_and_user_id", unique: true, using: :btree
  add_index "watchings", ["product_id"], name: "index_watchings_on_product_id", using: :btree
  add_index "watchings", ["user_id"], name: "index_watchings_on_user_id", using: :btree

end

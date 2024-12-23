# frozen_string_literal: true

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

ActiveRecord::Schema.define(version: 20_220_727_100_713) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'active_storage_attachments', force: :cascade do |t|
    t.string 'name', null: false
    t.string 'record_type', null: false
    t.bigint 'record_id', null: false
    t.bigint 'blob_id', null: false
    t.datetime 'created_at', null: false
    t.index ['blob_id'], name: 'index_active_storage_attachments_on_blob_id'
    t.index %w[record_type record_id name blob_id], name: 'index_active_storage_attachments_uniqueness',
                                                    unique: true
  end

  create_table 'active_storage_blobs', force: :cascade do |t|
    t.string 'key', null: false
    t.string 'filename', null: false
    t.string 'content_type'
    t.text 'metadata'
    t.bigint 'byte_size', null: false
    t.string 'checksum', null: false
    t.datetime 'created_at', null: false
    t.index ['key'], name: 'index_active_storage_blobs_on_key', unique: true
  end

  create_table 'cart_orders', force: :cascade do |t|
    t.bigint 'cart_id'
    t.bigint 'order_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['cart_id'], name: 'index_cart_orders_on_cart_id'
    t.index ['order_id'], name: 'index_cart_orders_on_order_id'
  end

  create_table 'cart_products', force: :cascade do |t|
    t.bigint 'cart_id'
    t.bigint 'product_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.integer 'quantity', default: 0
    t.index ['cart_id'], name: 'index_cart_products_on_cart_id'
    t.index ['product_id'], name: 'index_cart_products_on_product_id'
  end

  create_table 'carts', force: :cascade do |t|
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_carts_on_user_id'
  end

  create_table 'comments', force: :cascade do |t|
    t.text 'body'
    t.bigint 'product_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'user_id'
    t.index ['product_id'], name: 'index_comments_on_product_id'
    t.index ['user_id'], name: 'index_comments_on_user_id'
  end

  create_table 'cupons', force: :cascade do |t|
    t.string 'promo_code'
    t.integer 'discount_rate'
    t.datetime 'valid_til'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'order_products', force: :cascade do |t|
    t.bigint 'order_id'
    t.bigint 'product_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['order_id'], name: 'index_order_products_on_order_id'
    t.index ['product_id'], name: 'index_order_products_on_product_id'
  end

  create_table 'orders', force: :cascade do |t|
    t.float 'total_amount'
    t.float 'discounted_amount'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'cupon_id'
    t.index ['cupon_id'], name: 'index_orders_on_cupon_id'
    t.index ['user_id'], name: 'index_orders_on_user_id'
  end

  create_table 'orders_products', id: false, force: :cascade do |t|
    t.bigint 'order_id', null: false
    t.bigint 'product_id', null: false
  end

  create_table 'products', force: :cascade do |t|
    t.integer 'serial_no'
    t.string 'name'
    t.float 'price'
    t.text 'description'
    t.string 'images'
    t.bigint 'user_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.index ['user_id'], name: 'index_products_on_user_id'
  end

  create_table 'users', force: :cascade do |t|
    t.string 'picture'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'email', default: '', null: false
    t.string 'encrypted_password', default: '', null: false
    t.string 'reset_password_token'
    t.datetime 'reset_password_sent_at'
    t.datetime 'remember_created_at'
    t.string 'first_name'
    t.string 'last_name'
    t.index ['email'], name: 'index_users_on_email', unique: true
    t.index ['reset_password_token'], name: 'index_users_on_reset_password_token', unique: true
  end

  add_foreign_key 'active_storage_attachments', 'active_storage_blobs', column: 'blob_id'
  add_foreign_key 'cart_orders', 'carts'
  add_foreign_key 'cart_orders', 'orders'
  add_foreign_key 'cart_products', 'carts'
  add_foreign_key 'cart_products', 'products'
  add_foreign_key 'carts', 'users'
  add_foreign_key 'comments', 'products'
  add_foreign_key 'comments', 'users'
  add_foreign_key 'order_products', 'orders'
  add_foreign_key 'order_products', 'products'
  add_foreign_key 'orders', 'cupons'
  add_foreign_key 'orders', 'users'
  add_foreign_key 'products', 'users'
end

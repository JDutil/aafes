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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20100812004953) do

  create_table "approvals", :force => true do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "approvals", ["transaction_id"], :name => "index_approvals_on_transaction_id"
  add_index "approvals", ["user_id"], :name => "index_approvals_on_user_id"

  create_table "client_users", :force => true do |t|
    t.integer  "client_id"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "client_users", ["client_id"], :name => "index_client_users_on_client_id"
  add_index "client_users", ["user_id"], :name => "index_client_users_on_user_id"

  create_table "clients", :force => true do |t|
    t.integer  "facility_number"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "clients", ["facility_number"], :name => "index_clients_on_facility_number"

  create_table "credits", :force => true do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "credits", ["transaction_id"], :name => "index_credits_on_transaction_id"
  add_index "credits", ["user_id"], :name => "index_credits_on_user_id"

  create_table "roles", :force => true do |t|
    t.string   "title"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "settlements", :force => true do |t|
    t.integer  "amount"
    t.integer  "user_id"
    t.integer  "transaction_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "settlements", ["transaction_id"], :name => "index_settlements_on_transaction_id"
  add_index "settlements", ["user_id"], :name => "index_settlements_on_user_id"

  create_table "transactions", :force => true do |t|
    t.integer  "user_id"
    t.integer  "client_id"
    t.string   "order_id"
    t.string   "cc_number"
    t.integer  "amount"
    t.string   "auth_code"
    t.string   "auth_ticket"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "transactions", ["client_id"], :name => "index_transactions_on_client_id"
  add_index "transactions", ["order_id"], :name => "index_transactions_on_order_id"
  add_index "transactions", ["user_id"], :name => "index_transactions_on_user_id"

  create_table "users", :force => true do |t|
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.string   "perishable_token",                   :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.string   "confirmation_token"
    t.datetime "confirmed_on"
    t.boolean  "confirmed"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["confirmed"], :name => "index_users_on_confirmed"
  add_index "users", ["confirmed_on"], :name => "index_users_on_confirmed_on"
  add_index "users", ["current_login_at"], :name => "index_users_on_current_login_at"
  add_index "users", ["email"], :name => "index_users_on_email"
  add_index "users", ["last_login_at"], :name => "index_users_on_last_login_at"
  add_index "users", ["last_request_at"], :name => "index_users_on_last_request_at"

end

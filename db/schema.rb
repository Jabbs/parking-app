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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121122163748) do

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "leases", :force => true do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.boolean  "confirmed",  :default => false
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  create_table "listings", :force => true do |t|
    t.integer  "user_id"
    t.integer  "spot_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "start_time_slot"
    t.integer  "end_time_slot"
    t.integer  "price"
    t.integer  "building_id"
  end

  create_table "rent_hours", :force => true do |t|
    t.integer  "listing_id"
    t.boolean  "reserved",   :default => false
    t.integer  "renter_id"
    t.date     "date"
    t.integer  "time_slot"
    t.datetime "created_at",                    :null => false
    t.datetime "updated_at",                    :null => false
  end

  add_index "rent_hours", ["id"], :name => "index_rent_hours_on_id"

  create_table "spots", :force => true do |t|
    t.string   "name"
    t.integer  "building_id"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",                                :null => false
    t.datetime "updated_at",                                :null => false
    t.integer  "building_id"
    t.string   "auth_token"
    t.boolean  "verified",               :default => false
    t.string   "verification_token"
    t.datetime "verification_sent_at"
    t.datetime "verified_at"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "admin",                  :default => false
  end

end
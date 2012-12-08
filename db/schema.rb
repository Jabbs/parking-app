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

ActiveRecord::Schema.define(:version => 20121208174303) do

  create_table "buildings", :force => true do |t|
    t.string   "name"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.string   "code"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "zip_code"
    t.string   "image"
    t.text     "garage_instructions"
    t.boolean  "approved",            :default => false
    t.string   "website"
    t.string   "contact_name"
    t.string   "contact_email"
    t.string   "contact_phone"
    t.float    "latitude"
    t.float    "longitude"
  end

  create_table "cart_rent_hour_relationships", :force => true do |t|
    t.integer  "cart_id"
    t.integer  "rent_hour_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "carts", :force => true do |t|
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
    t.integer  "user_id"
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
    t.integer  "building_id"
  end

  create_table "rent_hours", :force => true do |t|
    t.integer  "listing_id"
    t.boolean  "reserved",    :default => false
    t.integer  "renter_id"
    t.date     "date"
    t.integer  "time_slot"
    t.datetime "created_at",                     :null => false
    t.datetime "updated_at",                     :null => false
    t.integer  "spot_id"
    t.integer  "building_id"
  end

  add_index "rent_hours", ["id"], :name => "index_rent_hours_on_id"

  create_table "reservation_rent_hour_relationships", :force => true do |t|
    t.integer  "reservation_id"
    t.integer  "rent_hour_id"
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "reservations", :force => true do |t|
    t.date     "start_date"
    t.date     "end_date"
    t.integer  "start_time_slot"
    t.integer  "end_time_slot"
    t.integer  "spot_id"
    t.integer  "user_id"
    t.datetime "created_at",                             :null => false
    t.datetime "updated_at",                             :null => false
    t.integer  "cart_id"
    t.boolean  "paid",                :default => false
    t.integer  "owner_id"
    t.string   "confirmation_number"
    t.string   "email"
    t.string   "license_plate"
  end

  create_table "searches", :force => true do |t|
    t.date     "end_date"
    t.integer  "building_id"
    t.datetime "created_at",      :null => false
    t.datetime "updated_at",      :null => false
    t.integer  "user_id"
    t.integer  "start_time_slot"
    t.integer  "end_time_slot"
    t.date     "start_date"
  end

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

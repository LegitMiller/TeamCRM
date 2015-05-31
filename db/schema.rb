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

ActiveRecord::Schema.define(version: 20150409213921) do

  create_table "notes", force: true do |t|
    t.string   "title"
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "record_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "notifications", force: true do |t|
    t.integer  "maker_id"
    t.integer  "user_id"
    t.integer  "thirdparty_id"
    t.integer  "record_id"
    t.string   "changetype"
    t.string   "change"
    t.boolean  "seen"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "phases", force: true do |t|
    t.string   "name"
    t.integer  "phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.string   "email"
    t.string   "title"
    t.string   "bio"
    t.boolean  "phasemail"
    t.boolean  "progressmail"
    t.boolean  "assignmail"
    t.string   "status"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "progressions", force: true do |t|
    t.string   "name"
    t.integer  "phase_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "records", force: true do |t|
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.string   "email"
    t.string   "raemail"
    t.datetime "receivedate"
    t.datetime "followupdate"
    t.string   "progress"
    t.string   "detailedprogress"
    t.boolean  "phasemail"
    t.boolean  "progressmail"
    t.float    "lopay"
    t.float    "propay"
    t.float    "jpay"
    t.float    "opay"
    t.boolean  "splitpay"
    t.integer  "loanofficer_id"
    t.integer  "processor_id"
    t.integer  "marketer_id"
    t.integer  "real_id"
    t.integer  "escrow_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "steps", force: true do |t|
    t.integer  "record_id"
    t.integer  "progression_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end

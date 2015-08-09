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

ActiveRecord::Schema.define(version: 20150809023823) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appt_appointment_types", force: :cascade do |t|
    t.string   "name",             null: false
    t.integer  "duration_minutes"
    t.integer  "before_minutes"
    t.integer  "after_minutes"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "appt_appointments", force: :cascade do |t|
    t.integer  "calendar_id"
    t.date     "day",                 null: false
    t.string   "start",               null: false
    t.string   "end",                 null: false
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.string   "phone"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "appointment_type_id"
  end

  create_table "appt_blocks", force: :cascade do |t|
    t.string   "name"
    t.integer  "calendar_id"
    t.date     "day",                  null: false
    t.string   "start",                null: false
    t.string   "end",                  null: false
    t.integer  "external_calendar_id"
    t.string   "external_id"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  create_table "appt_calendars", force: :cascade do |t|
    t.string   "name"
    t.text     "availability"
    t.string   "timezone_name"
    t.integer  "resolution_minutes"
    t.integer  "min_hours"
    t.integer  "max_days"
    t.integer  "lock_hours"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "appt_calendars_appointment_types", id: false, force: :cascade do |t|
    t.integer "calendar_id"
    t.integer "appointment_type_id"
  end

  add_index "appt_calendars_appointment_types", ["appointment_type_id"], name: "index_appt_calendars_appointment_types_on_appointment_type_id", using: :btree
  add_index "appt_calendars_appointment_types", ["calendar_id"], name: "index_appt_calendars_appointment_types_on_calendar_id", using: :btree

  create_table "appt_external_calendars", force: :cascade do |t|
    t.string   "url"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end

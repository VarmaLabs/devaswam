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

ActiveRecord::Schema.define(version: 20141104071504) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "deities", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "temple_id"
    t.integer  "trust_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unicode_name"
  end

  create_table "images", force: true do |t|
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.string   "caption"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offerings", force: true do |t|
    t.string   "name"
    t.integer  "deity_id"
    t.integer  "temple_id"
    t.float    "price"
    t.string   "notes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "devaswam_share"
    t.float    "shanti_share"
    t.float    "kazhakam_share"
    t.string   "unicode_name"
  end

  create_table "photos", force: true do |t|
    t.string   "image"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "super_admins", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "email"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unicode_name"
  end

  create_table "temples", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "trust_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unicode_name"
  end

  create_table "trust_admins", force: true do |t|
    t.string   "name"
    t.string   "username"
    t.string   "status"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.integer  "trust_id"
    t.string   "password_digest"
    t.string   "auth_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unicode_name"
  end

  create_table "trusts", force: true do |t|
    t.string   "name"
    t.string   "status"
    t.string   "email"
    t.string   "phone"
    t.string   "address"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "unicode_name"
  end

end

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

ActiveRecord::Schema.define(version: 20151214025536) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "badge_types", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "badges", force: :cascade do |t|
    t.integer  "badge_type_id"
    t.integer  "listing_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "badges", ["badge_type_id", "listing_id"], name: "index_badges_on_badge_type_id_and_listing_id", unique: true, using: :btree

  create_table "listing_photos", force: :cascade do |t|
    t.integer  "listing_id"
    t.integer  "photo_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listing_photos", ["listing_id", "photo_id"], name: "index_listing_photos_on_listing_id_and_photo_id", unique: true, using: :btree

  create_table "listings", force: :cascade do |t|
    t.integer  "saved_search_id"
    t.string   "reverb_id"
    t.string   "title"
    t.string   "url"
    t.string   "make"
    t.string   "model"
    t.datetime "date_created"
    t.integer  "year"
    t.string   "condition"
    t.integer  "price_cents"
    t.integer  "shipping_cents"
    t.string   "shop"
    t.boolean  "offers"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "listings", ["reverb_id", "saved_search_id"], name: "index_listings_on_reverb_id_and_saved_search_id", unique: true, using: :btree

  create_table "photos", force: :cascade do |t|
    t.string   "link"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "saved_searches", force: :cascade do |t|
    t.string   "query"
    t.string   "make"
    t.integer  "min_price",               default: 0
    t.integer  "max_price"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_matching_listings"
  end

  add_index "saved_searches", ["query"], name: "index_saved_searches_on_query", using: :btree

end

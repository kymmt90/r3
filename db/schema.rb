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

ActiveRecord::Schema.define(version: 20160609124426) do

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  add_index "categories", ["user_id", "name"], name: "index_categories_on_user_id_and_name", unique: true
  add_index "categories", ["user_id"], name: "index_categories_on_user_id"

  create_table "entries", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.string   "author"
    t.date     "published_at"
    t.text     "summary"
    t.integer  "feed_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "entries", ["feed_id"], name: "index_entries_on_feed_id"
  add_index "entries", ["url"], name: "index_entries_on_url", unique: true

  create_table "feed_categorizations", force: :cascade do |t|
    t.integer  "category_id", null: false
    t.integer  "feed_id",     null: false
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "feed_categorizations", ["category_id", "feed_id"], name: "index_feed_categorizations_on_category_id_and_feed_id", unique: true
  add_index "feed_categorizations", ["category_id"], name: "index_feed_categorizations_on_category_id"
  add_index "feed_categorizations", ["feed_id"], name: "index_feed_categorizations_on_feed_id"

  create_table "feeds", force: :cascade do |t|
    t.string   "title"
    t.string   "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "feed_url"
  end

  add_index "feeds", ["feed_url"], name: "index_feeds_on_feed_url", unique: true

  create_table "reading_statuses", force: :cascade do |t|
    t.integer  "user_id",              null: false
    t.integer  "entry_id",             null: false
    t.integer  "status",     limit: 2, null: false
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
  end

  add_index "reading_statuses", ["entry_id"], name: "index_reading_statuses_on_entry_id"
  add_index "reading_statuses", ["user_id", "entry_id"], name: "index_reading_statuses_on_user_id_and_entry_id", unique: true
  add_index "reading_statuses", ["user_id"], name: "index_reading_statuses_on_user_id"

  create_table "subscriptions", force: :cascade do |t|
    t.integer  "feed_id",    null: false
    t.integer  "user_id",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "subscriptions", ["feed_id", "user_id"], name: "index_subscriptions_on_feed_id_and_user_id", unique: true
  add_index "subscriptions", ["feed_id"], name: "index_subscriptions_on_feed_id"
  add_index "subscriptions", ["user_id"], name: "index_subscriptions_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.string   "remember_digest"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end

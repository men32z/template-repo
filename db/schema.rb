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

ActiveRecord::Schema.define(version: 2021_09_20_191152) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "status", force: :cascade do |t|
    t.string "name"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.integer "external_id"
    t.integer "external_provider"
    t.string "external_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "status_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["external_id", "external_provider"], name: "index_users_on_external_id_and_external_provider", unique: true
    t.index ["status_id"], name: "index_users_on_status_id"
  end

  add_foreign_key "users", "status"
end

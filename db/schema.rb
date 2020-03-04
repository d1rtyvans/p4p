# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_03_02_002757) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "resort_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resort_id"], name: "index_favorites_on_resort_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "forecasts", force: :cascade do |t|
    t.string "type", null: false
    t.date "date", null: false
    t.jsonb "weather_data", null: false
    t.bigint "resort_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["resort_id", "date", "type"], name: "index_forecasts_on_resort_id_and_date_and_type", unique: true
    t.index ["resort_id"], name: "index_forecasts_on_resort_id"
  end

  create_table "resorts", force: :cascade do |t|
    t.string "name", null: false
    t.string "uid", null: false
    t.decimal "lat", precision: 10, scale: 6, null: false
    t.decimal "lon", precision: 10, scale: 6, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["uid"], name: "index_resorts_on_uid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "forecasts", "resorts"
end

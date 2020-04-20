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

ActiveRecord::Schema.define(version: 2020_04_20_060916) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "currents", force: :cascade do |t|
    t.integer "temp"
    t.integer "high"
    t.integer "low"
    t.string "description"
    t.string "icon"
    t.integer "feels_like"
    t.integer "humidity"
    t.integer "visibility"
    t.integer "uv_index"
    t.string "sunrise"
    t.string "sunset"
    t.bigint "location_data_id"
    t.index ["location_data_id"], name: "index_currents_on_location_data_id"
  end

  create_table "dailies", force: :cascade do |t|
    t.string "day"
    t.string "icon"
    t.string "description"
    t.float "precipitation"
    t.integer "high"
    t.integer "low"
    t.bigint "location_data_id"
    t.index ["location_data_id"], name: "index_dailies_on_location_data_id"
  end

  create_table "hourlies", force: :cascade do |t|
    t.string "time"
    t.integer "temp"
    t.string "icon"
    t.bigint "location_data_id"
    t.index ["location_data_id"], name: "index_hourlies_on_location_data_id"
  end

  create_table "location_data", force: :cascade do |t|
    t.float "latitude"
    t.float "longitude"
    t.string "city"
    t.string "state"
    t.string "country"
    t.datetime "created_at"
    t.bigint "current_id"
    t.index ["current_id"], name: "index_location_data_on_current_id"
  end

  add_foreign_key "currents", "location_data", column: "location_data_id"
  add_foreign_key "dailies", "location_data", column: "location_data_id"
  add_foreign_key "hourlies", "location_data", column: "location_data_id"
  add_foreign_key "location_data", "currents"
end

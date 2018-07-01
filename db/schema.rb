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

ActiveRecord::Schema.define(version: 20180701062652) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bike_models", force: :cascade do |t|
    t.string "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "bikes", force: :cascade do |t|
    t.string "color"
    t.decimal "weight"
    t.decimal "latitude"
    t.decimal "longitude"
    t.bigint "bike_model_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "average_rating", default: "0.0"
    t.index ["bike_model_id"], name: "index_bikes_on_bike_model_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.datetime "start_date"
    t.datetime "end_date"
    t.integer "rating"
    t.boolean "cancelled", default: false
    t.bigint "user_id"
    t.bigint "bike_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["bike_id"], name: "index_reservations_on_bike_id"
    t.index ["user_id"], name: "index_reservations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.boolean "admin"
    t.string "password"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "bikes", "bike_models"
  add_foreign_key "reservations", "bikes"
  add_foreign_key "reservations", "users"
end

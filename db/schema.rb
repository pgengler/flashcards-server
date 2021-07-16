# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2021_07_16_210112) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "card_sets", id: :serial, force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "card_sets_cards", id: false, force: :cascade do |t|
    t.integer "card_id"
    t.integer "card_set_id"
    t.index ["card_id"], name: "index_card_sets_cards_on_card_id"
    t.index ["card_set_id"], name: "index_card_sets_cards_on_card_set_id"
  end

  create_table "cards", id: :serial, force: :cascade do |t|
    t.text "front"
    t.text "back"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.bigint "collection_id", null: false
    t.index ["collection_id"], name: "index_cards_on_collection_id"
  end

  create_table "collections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
  end

  add_foreign_key "cards", "collections"
end

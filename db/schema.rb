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

ActiveRecord::Schema.define(version: 2018_07_20_163202) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "categories_resources", id: false, force: :cascade do |t|
    t.bigint "category_id", null: false
    t.bigint "resource_id", null: false
  end

  create_table "external_resources", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "information_recommendations", force: :cascade do |t|
    t.string "recommender_name"
    t.string "recommender_email"
    t.text "information"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_information_recommendations_on_resource_id"
  end

  create_table "list_items", force: :cascade do |t|
    t.string "listable_type"
    t.bigint "listable_id"
    t.bigint "list_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["list_id"], name: "index_list_items_on_list_id"
    t.index ["listable_type", "listable_id"], name: "index_list_items_on_listable_type_and_listable_id"
  end

  create_table "lists", force: :cascade do |t|
    t.string "title"
    t.bigint "resource_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["resource_id"], name: "index_lists_on_resource_id"
  end

  create_table "resource_recommendations", force: :cascade do |t|
    t.string "recommender_name"
    t.string "recommender_email"
    t.string "name"
    t.string "website"
    t.string "other_information"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "resources", force: :cascade do |t|
    t.string "title"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "website"
    t.string "twitter"
    t.string "facebook"
    t.string "github"
    t.string "youtube"
  end

  add_foreign_key "information_recommendations", "resources"
  add_foreign_key "list_items", "lists"
  add_foreign_key "lists", "resources"
end

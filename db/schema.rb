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

ActiveRecord::Schema[8.1].define(version: 2026_01_08_132606) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "meal_events", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.integer "guests_count"
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_meal_events_on_user_id"
  end

  create_table "meal_plans", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.date "date", null: false
    t.string "meal_type", null: false
    t.bigint "recipe_id", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["recipe_id"], name: "index_meal_plans_on_recipe_id"
    t.index ["user_id", "date", "meal_type"], name: "index_meal_plans_on_user_id_and_date_and_meal_type", unique: true
    t.index ["user_id", "date"], name: "index_meal_plans_on_user_id_and_date"
    t.index ["user_id"], name: "index_meal_plans_on_user_id"
  end

  create_table "recipes", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.jsonb "ingredients", default: [], null: false
    t.boolean "is_favorite", default: false
    t.integer "preparation_time"
    t.jsonb "steps", default: [], null: false
    t.string "title", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["ingredients"], name: "index_recipes_on_ingredients", using: :gin
    t.index ["steps"], name: "index_recipes_on_steps", using: :gin
    t.index ["user_id"], name: "index_recipes_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.datetime "remember_created_at"
    t.datetime "reset_password_sent_at"
    t.string "reset_password_token"
    t.integer "role", default: 0, null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "meal_events", "users"
  add_foreign_key "meal_plans", "recipes"
  add_foreign_key "meal_plans", "users"
  add_foreign_key "recipes", "users"
end

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

ActiveRecord::Schema.define(version: 2019_04_07_014305) do

  create_table "posts", force: :cascade do |t|
    t.integer "user_id"
    t.integer "todo_post_id"
    t.string "commnet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["todo_post_id"], name: "index_posts_on_todo_post_id"
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "todo_posts", force: :cascade do |t|
    t.integer "todo_id"
    t.integer "post_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["post_id"], name: "index_todo_posts_on_post_id"
    t.index ["todo_id"], name: "index_todo_posts_on_todo_id"
  end

  create_table "todos", force: :cascade do |t|
    t.integer "users_id"
    t.integer "weight", default: 1, null: false
    t.integer "set_count", default: 1, null: false
    t.datetime "clear_plan"
    t.boolean "cleared"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "title"
    t.index ["users_id"], name: "index_todos_on_users_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name", default: "non-name", null: false
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

end

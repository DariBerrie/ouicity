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

ActiveRecord::Schema[7.0].define(version: 2022_11_17_201612) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "alerts", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.string "category"
    t.string "address"
    t.integer "upvotes"
    t.integer "status"
    t.bigint "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["creator_id"], name: "index_alerts_on_creator_id"
  end

  create_table "assignments", force: :cascade do |t|
    t.bigint "worker_id", null: false
    t.bigint "alert_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["alert_id"], name: "index_assignments_on_alert_id"
    t.index ["worker_id"], name: "index_assignments_on_worker_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.bigint "assignment_id", null: false
    t.bigint "worker_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_messages_on_assignment_id"
    t.index ["worker_id"], name: "index_messages_on_worker_id"
  end

  create_table "subscribers", force: :cascade do |t|
    t.bigint "subscriber_id", null: false
    t.bigint "assignment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["assignment_id"], name: "index_subscribers_on_assignment_id"
    t.index ["subscriber_id"], name: "index_subscribers_on_subscriber_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "address"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "alerts", "users", column: "creator_id"
  add_foreign_key "assignments", "alerts"
  add_foreign_key "assignments", "users", column: "worker_id"
  add_foreign_key "messages", "assignments"
  add_foreign_key "messages", "users", column: "worker_id"
  add_foreign_key "subscribers", "assignments"
  add_foreign_key "subscribers", "users", column: "subscriber_id"
end

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

ActiveRecord::Schema[8.0].define(version: 2025_09_12_115921) do
  create_table "contacts", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.string "phone"
    t.text "address"
    t.string "contact_type"
    t.text "notes"
    t.boolean "active", default: true
    t.integer "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_contacts_on_user_id"
  end

  create_table "deals", force: :cascade do |t|
    t.string "title"
    t.string "deal_type"
    t.string "status"
    t.decimal "purchase_price"
    t.decimal "loan_amount"
    t.integer "contact_id", null: false
    t.integer "loan_officer_id", null: false
    t.date "estimated_close_date"
    t.date "actual_close_date"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["contact_id"], name: "index_deals_on_contact_id"
    t.index ["loan_officer_id"], name: "index_deals_on_loan_officer_id"
  end

  create_table "documents", force: :cascade do |t|
    t.string "filename"
    t.string "file_type"
    t.integer "deal_id", null: false
    t.integer "user_id", null: false
    t.text "encrypted_file_data"
    t.datetime "upload_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_documents_on_deal_id"
    t.index ["user_id"], name: "index_documents_on_user_id"
  end

  create_table "messages", force: :cascade do |t|
    t.text "content"
    t.integer "user_id", null: false
    t.integer "deal_id", null: false
    t.string "message_type"
    t.datetime "read_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["deal_id"], name: "index_messages_on_deal_id"
    t.index ["user_id"], name: "index_messages_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "role", default: "loan_officer", null: false
    t.boolean "active", default: true
    t.string "phone"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "contacts", "users"
  add_foreign_key "deals", "contacts"
  add_foreign_key "deals", "users", column: "loan_officer_id"
  add_foreign_key "documents", "deals"
  add_foreign_key "documents", "users"
  add_foreign_key "messages", "deals"
  add_foreign_key "messages", "users"
end

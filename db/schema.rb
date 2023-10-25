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

ActiveRecord::Schema[7.0].define(version: 2023_10_25_052144) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email"
    t.string "first_name"
    t.string "last_name"
    t.string "user_name"
    t.string "gender"
    t.string "password_digest"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "role"
    t.string "type"
    t.bigint "phone_number"
  end

  create_table "accounts_specializations", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "specialization_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_accounts_specializations_on_account_id"
    t.index ["specialization_id"], name: "index_accounts_specializations_on_specialization_id"
  end

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "appointments", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "healthcareable_type"
    t.bigint "slot_id"
    t.bigint "account_id"
    t.date "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "status"
    t.index ["account_id"], name: "index_appointments_on_account_id"
    t.index ["patient_id"], name: "index_appointments_on_patient_id"
    t.index ["slot_id"], name: "index_appointments_on_slot_id"
  end

  create_table "coach_sessions", force: :cascade do |t|
    t.bigint "account_id"
    t.string "type"
    t.string "start_time"
    t.string "end_time"
    t.decimal "entery_fee"
    t.decimal "fees"
    t.integer "status"
    t.text "notes"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_coach_sessions_on_account_id"
  end

  create_table "coaches", force: :cascade do |t|
    t.string "name"
    t.datetime "practicing_from"
    t.text "professional_statement"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_time"
    t.string "end_time"
    t.index ["account_id"], name: "index_coaches_on_account_id"
  end

  create_table "departments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "doctors", force: :cascade do |t|
    t.string "name"
    t.datetime "practicing_from"
    t.text "professional_statement"
    t.bigint "account_id"
    t.bigint "department_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "start_time"
    t.string "end_time"
    t.integer "status"
    t.index ["account_id"], name: "index_doctors_on_account_id"
    t.index ["department_id"], name: "index_doctors_on_department_id"
  end

  create_table "instructions", force: :cascade do |t|
    t.string "instruction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_coach_sessions", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "patient_id"
    t.bigint "coach_session_id"
    t.date "date"
    t.integer "payment_status"
    t.bigint "session_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_patient_coach_sessions_on_account_id"
    t.index ["coach_session_id"], name: "index_patient_coach_sessions_on_coach_session_id"
    t.index ["patient_id"], name: "index_patient_coach_sessions_on_patient_id"
    t.index ["session_id"], name: "index_patient_coach_sessions_on_session_id"
  end

  create_table "patient_tests", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "test_name"
    t.string "organization"
    t.datetime "date"
    t.decimal "fee"
    t.text "description"
    t.bigint "account_id"
    t.string "lab_assistent"
    t.integer "status"
    t.bigint "report_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_patient_tests_on_account_id"
    t.index ["patient_id"], name: "index_patient_tests_on_patient_id"
    t.index ["report_id"], name: "index_patient_tests_on_report_id"
  end

  create_table "patient_triages", force: :cascade do |t|
    t.bigint "patient_id"
    t.string "blood_pressure"
    t.string "sugar_level"
    t.string "blood_group"
    t.string "heart_beat"
    t.string "height"
    t.string "weight"
    t.decimal "fee"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_patient_triages_on_patient_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.string "email"
    t.bigint "phone_number"
    t.integer "age"
    t.text "address"
    t.string "gender"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_patients_on_account_id"
  end

  create_table "payments", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "patient_id"
    t.string "payment_id"
    t.decimal "amount"
    t.datetime "date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_payments_on_account_id"
    t.index ["patient_id"], name: "index_payments_on_patient_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "duration"
    t.integer "quantity"
    t.bigint "medicine_id"
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "account_id"
    t.bigint "instruction_id"
    t.index ["account_id"], name: "index_prescriptions_on_account_id"
    t.index ["instruction_id"], name: "index_prescriptions_on_instruction_id"
    t.index ["medicine_id"], name: "index_prescriptions_on_medicine_id"
    t.index ["patient_id"], name: "index_prescriptions_on_patient_id"
  end

  create_table "reports", force: :cascade do |t|
    t.bigint "patient_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["patient_id"], name: "index_reports_on_patient_id"
  end

  create_table "sessions", force: :cascade do |t|
    t.string "session_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "slots", force: :cascade do |t|
    t.string "slot_time"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string "specialization_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "appointments", "accounts"
  add_foreign_key "appointments", "accounts", column: "patient_id"
  add_foreign_key "patient_coach_sessions", "accounts", column: "patient_id"
  add_foreign_key "patient_tests", "accounts", column: "patient_id"
  add_foreign_key "patient_triages", "accounts", column: "patient_id"
  add_foreign_key "payments", "accounts", column: "patient_id"
  add_foreign_key "prescriptions", "accounts", column: "patient_id"
  add_foreign_key "reports", "accounts", column: "patient_id"
end

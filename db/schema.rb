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

ActiveRecord::Schema[7.1].define(version: 2025_09_03_152204) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.string "status"
    t.bigint "pet_id", null: false
    t.bigint "availability_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["availability_id"], name: "index_appointments_on_availability_id"
    t.index ["pet_id"], name: "index_appointments_on_pet_id"
  end

  create_table "availabilities", force: :cascade do |t|
    t.datetime "start_time", precision: nil
    t.datetime "end_time", precision: nil
    t.boolean "is_available"
    t.string "day_of_week"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_availabilities_on_user_id"
  end

  create_table "medicines", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.string "category"
    t.text "instructions"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pets", force: :cascade do |t|
    t.string "name"
    t.string "species"
    t.integer "age"
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "other_species"
    t.date "birthdate"
    t.index ["user_id"], name: "index_pets_on_user_id"
  end

  create_table "prescriptions", force: :cascade do |t|
    t.string "dosage"
    t.datetime "start_date", precision: nil
    t.datetime "end_date", precision: nil
    t.text "special_instructions"
    t.bigint "medicine_id", null: false
    t.bigint "appointment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["appointment_id"], name: "index_prescriptions_on_appointment_id"
    t.index ["medicine_id"], name: "index_prescriptions_on_medicine_id"
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
    t.string "phone"
    t.string "address"
    t.string "specialty"
    t.string "city"
    t.string "clinic_name"
    t.integer "role"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "availabilities"
  add_foreign_key "appointments", "pets"
  add_foreign_key "availabilities", "users"
  add_foreign_key "pets", "users"
  add_foreign_key "prescriptions", "appointments"
  add_foreign_key "prescriptions", "medicines"
end

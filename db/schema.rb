# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20150515145700) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bodyparts", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "patient_answers", force: :cascade do |t|
    t.integer  "patient_id"
    t.integer  "survey_question_id"
    t.string   "answer"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
  end

  create_table "patients", force: :cascade do |t|
    t.string   "token"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.integer  "user_id"
    t.integer  "bodypart_id"
    t.integer  "presentation_id"
    t.boolean  "form_reached"
    t.datetime "appointment_time"
    t.boolean  "questionnaire_complete", default: false
  end

  add_index "patients", ["token"], name: "index_patients_on_token", unique: true, using: :btree

  create_table "practices", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "presentations", force: :cascade do |t|
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "bodypart_id"
  end

  create_table "survey_questions", force: :cascade do |t|
    t.text     "question"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.string   "presentation_id"
    t.boolean  "mandatory",       default: false
    t.string   "question_type"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "password_digest"
    t.boolean  "admin",                  default: false
    t.boolean  "clinician",              default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "practice_id"
    t.string   "password_reset_token"
    t.datetime "password_reset_sent_at"
    t.boolean  "super_user",             default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

end

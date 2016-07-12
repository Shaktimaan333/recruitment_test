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

ActiveRecord::Schema.define(version: 20160712080544) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "admin_users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "attempts", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "exam_id"
    t.integer  "freq"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.float    "ability"
    t.datetime "start_time"
    t.integer  "count",      default: 0, null: false
  end

  create_table "categories", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "mark"
    t.integer  "exam_id"
  end

  create_table "exams", force: :cascade do |t|
    t.string   "topic"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.integer  "no"
    t.string   "category_name"
    t.float    "average"
  end

  create_table "headshot_photos", force: :cascade do |t|
    t.string   "description"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.integer  "capturable_id"
    t.string   "capturable_type"
    t.datetime "image_updated_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "tryimage_file_name"
    t.string   "tryimage_content_type"
    t.integer  "tryimage_file_size"
    t.datetime "tryimage_updated_at"
  end

  create_table "miscs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "attempt"
    t.boolean  "terms"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "problems", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "email"
    t.text     "query"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "profiles", force: :cascade do |t|
    t.string   "name"
    t.text     "exam"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ques", force: :cascade do |t|
    t.integer  "category_id"
    t.string   "question"
    t.string   "one"
    t.string   "two"
    t.string   "three"
    t.string   "four"
    t.string   "correct"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.integer  "no_attempt"
    t.integer  "correct_attempt"
    t.integer  "wrong_attempt"
    t.string   "ione_file_name"
    t.string   "ione_content_type"
    t.integer  "ione_file_size"
    t.datetime "ione_updated_at"
    t.string   "itwo_file_name"
    t.string   "itwo_content_type"
    t.integer  "itwo_file_size"
    t.datetime "itwo_updated_at"
    t.string   "ithree_file_name"
    t.string   "ithree_content_type"
    t.integer  "ithree_file_size"
    t.datetime "ithree_updated_at"
    t.string   "ifour_file_name"
    t.string   "ifour_content_type"
    t.integer  "ifour_file_size"
    t.datetime "ifour_updated_at"
    t.decimal  "diff"
    t.decimal  "a"
    t.decimal  "c"
    t.string   "iques_file_name"
    t.string   "iques_content_type"
    t.integer  "iques_file_size"
    t.datetime "iques_updated_at"
  end

  create_table "scores", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "attempt"
    t.integer  "mark"
    t.integer  "exam_id"
    t.integer  "category_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "ques_id"
    t.integer  "last"
    t.integer  "cat_count"
    t.integer  "diff"
  end

  create_table "sheets", force: :cascade do |t|
    t.integer  "ques_id"
    t.boolean  "one"
    t.boolean  "two"
    t.boolean  "three"
    t.boolean  "four"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "updated"
    t.integer  "attempt_id"
    t.boolean  "correct"
    t.integer  "answer"
    t.float    "current_ability"
  end

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
    t.string   "password_digest"
    t.string   "mobileno"
    t.string   "classten"
    t.string   "classtwelve"
    t.string   "achievements"
    t.string   "experience"
    t.string   "projects"
    t.string   "remember_digest"
    t.boolean  "admin"
    t.integer  "freq"
    t.integer  "count"
    t.integer  "under_test"
    t.integer  "exam_id"
    t.integer  "redi"
    t.integer  "attempt_id"
    t.string   "activation_digest"
    t.boolean  "activated",         default: false
    t.datetime "activated_at"
    t.string   "reset_digest"
    t.datetime "reset_sent_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true

end

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

ActiveRecord::Schema.define(version: 20150722165000) do

  create_table "checklist_items", force: :cascade do |t|
    t.string   "title"
    t.boolean  "checked"
    t.integer  "checklist_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  add_index "checklist_items", ["checklist_id"], name: "index_checklist_items_on_checklist_id"

  create_table "checklists", force: :cascade do |t|
    t.string   "title"
    t.integer  "circle_id"
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "checklists", ["circle_id"], name: "index_checklists_on_circle_id"
  add_index "checklists", ["user_id"], name: "index_checklists_on_user_id"

  create_table "circles", force: :cascade do |t|
    t.string   "name"
    t.integer  "circle_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "category"
    t.string   "slug"
  end

  add_index "circles", ["circle_id"], name: "index_circles_on_circle_id"

  create_table "circles_members", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "circle_id"
    t.string   "designation"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "circles_members", ["circle_id"], name: "index_circles_members_on_circle_id"
  add_index "circles_members", ["member_id"], name: "index_circles_members_on_member_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    limit: 30
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], name: "idx_ckeditor_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], name: "idx_ckeditor_assetable_type"

  create_table "comments", force: :cascade do |t|
    t.string   "content"
    t.integer  "user_id"
    t.integer  "post_id"
    t.string   "post_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["user_id"], name: "index_comments_on_user_id"

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",                      null: false
    t.integer  "sluggable_id",              null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope"
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"

  create_table "members", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "slug"
    t.integer  "user_id"
    t.integer  "category"
  end

  create_table "members_roles", force: :cascade do |t|
    t.integer  "member_id"
    t.integer  "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "members_roles", ["member_id"], name: "index_members_roles_on_member_id"
  add_index "members_roles", ["role_id"], name: "index_members_roles_on_role_id"

  create_table "reports", force: :cascade do |t|
    t.string   "title"
    t.date     "date"
    t.string   "duration"
    t.string   "venue"
    t.string   "initiator"
    t.string   "bucket"
    t.string   "participants"
    t.text     "description"
    t.text     "conclusion"
    t.string   "author"
    t.boolean  "inter"
    t.string   "othbucket"
    t.time     "time"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "category"
    t.string   "slug"
  end

  create_table "roles", force: :cascade do |t|
    t.integer  "circle_id"
    t.integer  "member_id"
    t.string   "name"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "roles", ["circle_id"], name: "index_roles_on_circle_id"
  add_index "roles", ["member_id"], name: "index_roles_on_member_id"

  create_table "tasks", force: :cascade do |t|
    t.string   "title"
    t.string   "category"
    t.text     "description"
    t.integer  "circle_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "tasks", ["circle_id"], name: "index_tasks_on_circle_id"

  create_table "users", force: :cascade do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role"
    t.string   "slug"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "versions", force: :cascade do |t|
    t.string   "item_type",  null: false
    t.integer  "item_id",    null: false
    t.string   "event",      null: false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], name: "index_versions_on_item_type_and_item_id"

end

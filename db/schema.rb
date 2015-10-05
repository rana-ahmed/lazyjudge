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

ActiveRecord::Schema.define(version: 20151005204429) do

  create_table "clarifications", force: :cascade do |t|
    t.text     "question"
    t.text     "answer",     default: "<Not answered, yet>"
    t.integer  "user_id"
    t.integer  "problem_id"
    t.datetime "created_at",                                 null: false
    t.datetime "updated_at",                                 null: false
    t.integer  "judge_id"
  end

  add_index "clarifications", ["problem_id"], name: "index_clarifications_on_problem_id"
  add_index "clarifications", ["user_id"], name: "index_clarifications_on_user_id"

  create_table "problems", force: :cascade do |t|
    t.string   "title"
    t.string   "time_limit",         default: "1s"
    t.string   "memory_limit",       default: "1024"
    t.text     "description"
    t.text     "input_description",  default: "n/a"
    t.text     "output_description", default: "n/a"
    t.text     "sample_input",       default: "n/a"
    t.text     "sample_output",      default: "n/a"
    t.text     "judge_input",        default: ""
    t.text     "judge_output",       default: ""
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  create_table "users", force: :cascade do |t|
    t.string   "user_name"
    t.string   "password_digest"
    t.integer  "role",            default: 0
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

end

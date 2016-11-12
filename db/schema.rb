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

ActiveRecord::Schema.define(version: 20161111202829) do

  create_table "availabilities", force: :cascade do |t|
    t.integer  "volunteer_user_id"
    t.time     "mon_st"
    t.time     "mon_en"
    t.time     "tues_st"
    t.time     "tues_en"
    t.time     "wed_st"
    t.time     "wed_en"
    t.time     "thur_st"
    t.time     "thur_en"
    t.time     "fri_st"
    t.time     "fri_en"
    t.time     "sat_st"
    t.time     "sat_en"
    t.time     "sun_st"
    t.time     "sun_en"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["volunteer_user_id"], name: "index_availabilities_on_volunteer_user_id", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.string   "user_type"
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["user_type", "user_id"], name: "index_notifications_on_user_type_and_user_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followed_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "request_post_jobs", force: :cascade do |t|
    t.integer  "request_post_id"
    t.string   "title"
    t.text     "description"
    t.time     "avail"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["request_post_id"], name: "index_request_post_jobs_on_request_post_id"
  end

  create_table "request_post_updates", force: :cascade do |t|
    t.integer  "request_post_id"
    t.string   "title"
    t.text     "text"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["request_post_id"], name: "index_request_post_updates_on_request_post_id"
  end

  create_table "request_posts", force: :cascade do |t|
    t.string   "title"
    t.string   "location"
    t.date     "date"
    t.text     "description"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "request_user_id"
  end

  create_table "request_user_scorecards", force: :cascade do |t|
    t.integer  "request_user_id"
    t.integer  "leadership"
    t.integer  "treatment"
    t.integer  "committedness"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  create_table "request_users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "display_name"
    t.string "tel_num"
    t.string "fax_num"
    t.string "website_address"
    t.text   "about_me"
    t.string "remember_digest"
    t.index ["email"], name: "index_request_users_on_email", unique: true
  end

  create_table "skills", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_scorecards", force: :cascade do |t|
    t.integer  "volunteer_user_id"
    t.float    "skill_proficiency"
    t.float    "attitude"
    t.float    "enthusiasm"
    t.float    "reliability"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  create_table "volunteer_user_skills", force: :cascade do |t|
    t.string   "title"
    t.integer  "volunteer_user_id"
    t.integer  "skill_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
    t.index ["skill_id"], name: "index_volunteer_user_skills_on_skill_id"
    t.index ["volunteer_user_id"], name: "index_volunteer_user_skills_on_volunteer_user_id"
  end

  create_table "volunteer_users", force: :cascade do |t|
    t.string  "display_name"
    t.string  "email"
    t.string  "password_digest"
    t.text    "about_me"
    t.string  "zip_code"
    t.integer "points"
    t.integer "rev_count"
    t.boolean "no_search"
    t.string  "remember_digest"
    t.index ["email"], name: "index_volunteer_users_on_email", unique: true
  end

end

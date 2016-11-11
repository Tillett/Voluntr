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

ActiveRecord::Schema.define(version: 20161108035607) do

  create_table "availabilities", force: :cascade do |t|
    t.integer  "volunteer_user_id"
    t.integer  "mon_st"
    t.integer  "mon_en"
    t.integer  "tues_st"
    t.integer  "tues_en"
    t.integer  "wed_st"
    t.integer  "wed_en"
    t.integer  "thur_st"
    t.integer  "thur_en"
    t.integer  "fri_st"
    t.integer  "fri_en"
    t.integer  "sat_st"
    t.integer  "sat_en"
    t.integer  "sun_st"
    t.integer  "sun_en"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
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
  
  create_table "request_post_jobs", force: :cascade do |t|
    t.integer   "request_post_id"
    t.string    "title"
    t.text      "description"
    t.time  "avail"
    t.integer   "user_id"
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
    t.integer  "skill_proficiency"
    t.integer  "attitude"
    t.integer  "enthusiasm"
    t.integer  "reliability"
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

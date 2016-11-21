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

ActiveRecord::Schema.define(version: 20161115122140) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "chat_schedules", force: :cascade do |t|
    t.string   "name",        default: "", null: false
    t.date     "date",        default: [],              array: true
    t.string   "my_time",     default: [],              array: true
    t.string   "description", default: [],              array: true
    t.string   "info",        default: "", null: false
    t.integer  "group_id",    default: [],              array: true
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  create_table "chats", force: :cascade do |t|
    t.integer  "sender_id"
    t.integer  "group_id"
    t.integer  "chat_schedule_id"
    t.string   "quick_msg",        default: "",    null: false
    t.boolean  "activity",         default: false
    t.string   "file",             default: ""
    t.string   "file_type",        default: "",    null: false
    t.integer  "user_ids",         default: [],                 array: true
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "chats", ["chat_schedule_id"], name: "index_chats_on_chat_schedule_id", using: :btree
  add_index "chats", ["group_id"], name: "index_chats_on_group_id", using: :btree
  add_index "chats", ["sender_id"], name: "index_chats_on_sender_id", using: :btree

  create_table "companies", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "company_galeries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file",       default: ""
    t.string   "file_type",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "company_galeries", ["user_id"], name: "index_company_galeries_on_user_id", using: :btree

  create_table "company_stocks", force: :cascade do |t|
    t.string   "sensex_co",  default: "", null: false
    t.string   "sensex",     default: "", null: false
    t.string   "currency",   default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "courses", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "uuid"
    t.string   "registration_id"
    t.uuid     "token"
    t.string   "device_type"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "faculty_affiliations", force: :cascade do |t|
    t.integer  "user_id"
    t.boolean  "university",   default: false
    t.string   "collage_name", default: "",           null: false
    t.string   "subject",      default: "",           null: false
    t.string   "designation",  default: "",           null: false
    t.date     "join_from",    default: '2016-11-21'
    t.date     "join_till",    default: '2016-11-21'
    t.string   "file",         default: ""
    t.string   "file_type",    default: "",           null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "faculty_affiliations", ["user_id"], name: "index_faculty_affiliations_on_user_id", using: :btree

  create_table "faculty_publications", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.string   "file",        default: ""
    t.string   "text_field",  default: "", null: false
    t.string   "file_type",   default: "", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "faculty_publications", ["user_id"], name: "index_faculty_publications_on_user_id", using: :btree

  create_table "faculty_researches", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.string   "file",        default: ""
    t.string   "text_field",  default: "", null: false
    t.string   "file_type",   default: "", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "faculty_researches", ["user_id"], name: "index_faculty_researches_on_user_id", using: :btree

  create_table "faculty_workshops", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.string   "file",        default: ""
    t.string   "file_type",   default: "", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "faculty_workshops", ["user_id"], name: "index_faculty_workshops_on_user_id", using: :btree

  create_table "folders", force: :cascade do |t|
    t.string   "name",           default: "",    null: false
    t.boolean  "default_status", default: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  create_table "graphs", force: :cascade do |t|
    t.integer  "company_stock_id"
    t.integer  "industry_id"
    t.string   "company_code"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  add_index "graphs", ["company_stock_id"], name: "index_graphs_on_company_stock_id", using: :btree
  add_index "graphs", ["industry_id"], name: "index_graphs_on_industry_id", using: :btree

  create_table "group_invitees", force: :cascade do |t|
    t.integer  "group_id"
    t.string   "email",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "group_invitees", ["group_id"], name: "index_group_invitees_on_group_id", using: :btree

  create_table "group_users", force: :cascade do |t|
    t.integer  "group_id",                   null: false
    t.integer  "user_id",                    null: false
    t.boolean  "admin",      default: false
    t.integer  "status"
    t.datetime "deleted_at"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "group_users", ["group_id"], name: "index_group_users_on_group_id", using: :btree
  add_index "group_users", ["user_id"], name: "index_group_users_on_user_id", using: :btree

  create_table "groups", force: :cascade do |t|
    t.string   "name",         default: "", null: false
    t.string   "slug",         default: "", null: false
    t.integer  "code",                      null: false
    t.string   "group_pic",    default: ""
    t.integer  "deleted_from", default: [],              array: true
    t.datetime "created_at",                null: false
    t.datetime "updated_at",                null: false
  end

  add_index "groups", ["slug"], name: "index_groups_on_slug", unique: true, using: :btree

  create_table "industries", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "marketiqs", force: :cascade do |t|
    t.integer  "industry_id"
    t.integer  "specialization_id"
    t.string   "question",          default: "",    null: false
    t.string   "option_a",          default: "",    null: false
    t.string   "option_b",          default: "",    null: false
    t.string   "option_c",          default: "",    null: false
    t.string   "option_d",          default: "",    null: false
    t.string   "answer",            default: "",    null: false
    t.boolean  "role",              default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "marketiqs", ["industry_id"], name: "index_marketiqs_on_industry_id", using: :btree
  add_index "marketiqs", ["specialization_id"], name: "index_marketiqs_on_specialization_id", using: :btree

  create_table "quick_messages", force: :cascade do |t|
    t.string   "text",       default: "",    null: false
    t.boolean  "role",       default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  create_table "rpush_apps", force: :cascade do |t|
    t.string   "name",                                null: false
    t.string   "environment"
    t.text     "certificate"
    t.string   "password"
    t.integer  "connections",             default: 1, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "type",                                null: false
    t.string   "auth_key"
    t.string   "client_id"
    t.string   "client_secret"
    t.string   "access_token"
    t.datetime "access_token_expiration"
  end

  create_table "rpush_feedback", force: :cascade do |t|
    t.string   "device_token", limit: 64, null: false
    t.datetime "failed_at",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "app_id"
  end

  add_index "rpush_feedback", ["device_token"], name: "index_rpush_feedback_on_device_token", using: :btree

  create_table "rpush_notifications", force: :cascade do |t|
    t.integer  "badge"
    t.string   "device_token",      limit: 64
    t.string   "sound",                        default: "default"
    t.text     "alert"
    t.text     "data"
    t.integer  "expiry",                       default: 86400
    t.boolean  "delivered",                    default: false,     null: false
    t.datetime "delivered_at"
    t.boolean  "failed",                       default: false,     null: false
    t.datetime "failed_at"
    t.integer  "error_code"
    t.text     "error_description"
    t.datetime "deliver_after"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "alert_is_json",                default: false
    t.string   "type",                                             null: false
    t.string   "collapse_key"
    t.boolean  "delay_while_idle",             default: false,     null: false
    t.text     "registration_ids"
    t.integer  "app_id",                                           null: false
    t.integer  "retries",                      default: 0
    t.string   "uri"
    t.datetime "fail_after"
    t.boolean  "processing",                   default: false,     null: false
    t.integer  "priority"
    t.text     "url_args"
    t.string   "category"
    t.boolean  "content_available",            default: false
    t.text     "notification"
  end

  add_index "rpush_notifications", ["delivered", "failed"], name: "index_rpush_notifications_multi", where: "((NOT delivered) AND (NOT failed))", using: :btree

  create_table "settings", force: :cascade do |t|
    t.string   "site_name",       default: "Selfiecv.com",              null: false
    t.string   "site_email",      default: "selfiecv2016@gmail.com",    null: false
    t.string   "site_phone",      default: "9988776655",                null: false
    t.string   "site_fax",        default: "432456",                    null: false
    t.string   "facebook_url",    default: "www.facebook.com/Selfiecv", null: false
    t.string   "twitter_url",     default: "www.twitter.com/Selfiecv",  null: false
    t.string   "google_plus_url", default: "www.google.com/Selfiecv",   null: false
    t.string   "whizquiz_time",   default: "0"
    t.string   "marketiq_time",   default: "0"
    t.datetime "created_at",                                            null: false
    t.datetime "updated_at",                                            null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "student_educations", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "standard",   default: "", null: false
    t.string   "year",       default: "", null: false
    t.string   "school",     default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "student_educations", ["user_id"], name: "index_student_educations_on_user_id", using: :btree

  create_table "user_awards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",        default: "",      null: false
    t.string   "award_type",  default: "award", null: false
    t.string   "description", default: "",      null: false
    t.string   "file",        default: ""
    t.string   "text_field",  default: "",      null: false
    t.string   "file_type",   default: "",      null: false
    t.boolean  "active",      default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "user_awards", ["user_id"], name: "index_user_awards_on_user_id", using: :btree

  create_table "user_certificates", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "certificate_type", default: "",    null: false
    t.string   "name",             default: "",    null: false
    t.string   "year",             default: "",    null: false
    t.string   "file",             default: ""
    t.string   "text_field",       default: "",    null: false
    t.string   "file_type",        default: "",    null: false
    t.boolean  "active",           default: false
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "user_certificates", ["user_id"], name: "index_user_certificates_on_user_id", using: :btree

  create_table "user_curriculars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "curricular_type", default: "",           null: false
    t.string   "title",           default: "",           null: false
    t.string   "team_type",       default: "",           null: false
    t.string   "location",        default: "",           null: false
    t.date     "date",            default: '2016-11-21'
    t.string   "hobby",           default: "",           null: false
    t.string   "file",            default: ""
    t.string   "text_field",      default: "",           null: false
    t.string   "file_type",       default: "",           null: false
    t.boolean  "active",          default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "user_curriculars", ["user_id"], name: "index_user_curriculars_on_user_id", using: :btree

  create_table "user_educations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "specialization_id"
    t.string   "year",              default: "",    null: false
    t.string   "school",            default: "",    null: false
    t.string   "skill",             default: "",    null: false
    t.boolean  "active",            default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "user_educations", ["course_id"], name: "index_user_educations_on_course_id", using: :btree
  add_index "user_educations", ["specialization_id"], name: "index_user_educations_on_specialization_id", using: :btree
  add_index "user_educations", ["user_id"], name: "index_user_educations_on_user_id", using: :btree

  create_table "user_environments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "env_type",   default: "",    null: false
    t.string   "title",      default: "",    null: false
    t.string   "file",       default: ""
    t.string   "text_field", default: "",    null: false
    t.string   "file_type",  default: "",    null: false
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_environments", ["user_id"], name: "index_user_environments_on_user_id", using: :btree

  create_table "user_experiences", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",            default: "",           null: false
    t.string   "exp_type",        default: "",           null: false
    t.date     "start_from",      default: '2016-11-21'
    t.date     "working_till",    default: '2016-11-21'
    t.string   "designation",     default: "",           null: false
    t.string   "description",     default: "",           null: false
    t.string   "file",            default: ""
    t.string   "text_field",      default: "",           null: false
    t.string   "file_type",       default: "",           null: false
    t.boolean  "active",          default: false
    t.boolean  "current_company", default: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "user_experiences", ["user_id"], name: "index_user_experiences_on_user_id", using: :btree

  create_table "user_favourites", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "favourite_id"
    t.integer  "folder_id"
    t.boolean  "is_favourited", default: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "user_favourites", ["folder_id"], name: "index_user_favourites_on_folder_id", using: :btree
  add_index "user_favourites", ["user_id", "favourite_id"], name: "index_user_favourites_on_user_id_and_favourite_id", using: :btree

  create_table "user_folders", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "folder_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_folders", ["folder_id"], name: "index_user_folders_on_folder_id", using: :btree
  add_index "user_folders", ["user_id"], name: "index_user_folders_on_user_id", using: :btree

  create_table "user_future_goals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "goal_type",  default: "",    null: false
    t.string   "title",      default: "",    null: false
    t.string   "term_type",  default: "",    null: false
    t.string   "file",       default: ""
    t.string   "text_field", default: "",    null: false
    t.string   "file_type",  default: "",    null: false
    t.boolean  "active",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_future_goals", ["user_id"], name: "index_user_future_goals_on_user_id", using: :btree

  create_table "user_likes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "like_id"
    t.boolean  "is_liked",   default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_likes", ["user_id", "like_id"], name: "index_user_likes_on_user_id_and_like_id", using: :btree

  create_table "user_marketiqs", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "marketiq_id"
    t.string   "answer",      default: "",    null: false
    t.boolean  "status",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "user_marketiqs", ["marketiq_id"], name: "index_user_marketiqs_on_marketiq_id", using: :btree
  add_index "user_marketiqs", ["user_id"], name: "index_user_marketiqs_on_user_id", using: :btree

  create_table "user_marksheets", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "school_name", default: "", null: false
    t.string   "standard",    default: "", null: false
    t.string   "grade",       default: "", null: false
    t.string   "year",        default: "", null: false
    t.string   "file",        default: ""
    t.string   "file_type",   default: "", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_marksheets", ["user_id"], name: "index_user_marksheets_on_user_id", using: :btree

  create_table "user_meters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "resume_per",                 default: 0, null: false
    t.integer  "resume_info_per",            default: 0, null: false
    t.integer  "education_per",              default: 0, null: false
    t.integer  "experience_per",             default: 0, null: false
    t.integer  "prework_per",                default: 0, null: false
    t.integer  "achievement_per",            default: 0, null: false
    t.integer  "award_per",                  default: 0, null: false
    t.integer  "certificate_per",            default: 0, null: false
    t.integer  "curri_per",                  default: 0, null: false
    t.integer  "whizquiz_per",               default: 0, null: false
    t.integer  "future_goal_per",            default: 0, null: false
    t.integer  "working_env_per",            default: 0, null: false
    t.integer  "ref_per",                    default: 0, null: false
    t.integer  "company_info_per",           default: 0, null: false
    t.integer  "corporate_identity_per",     default: 0, null: false
    t.integer  "growth_and_goal_per",        default: 0, null: false
    t.integer  "evalution_per",              default: 0, null: false
    t.integer  "galery_per",                 default: 0, null: false
    t.integer  "student_basic_info_per",     default: 0, null: false
    t.integer  "student_education_per",      default: 0, null: false
    t.integer  "student_education_info_per", default: 0, null: false
    t.integer  "student_marksheet_per",      default: 0, null: false
    t.integer  "student_project_per",        default: 0, null: false
    t.integer  "faculty_basic_info_per",     default: 0, null: false
    t.integer  "faculty_affiliation_per",    default: 0, null: false
    t.integer  "faculty_workshop_per",       default: 0, null: false
    t.integer  "faculty_publication_per",    default: 0, null: false
    t.integer  "faculty_research_per",       default: 0, null: false
    t.integer  "like_per",                   default: 0, null: false
    t.integer  "rate_per",                   default: 0, null: false
    t.integer  "bronze_per",                 default: 0, null: false
    t.integer  "silver_per",                 default: 0, null: false
    t.integer  "gold_per",                   default: 0, null: false
    t.integer  "update_info_per",            default: 0, null: false
    t.integer  "share_per",                  default: 0, null: false
    t.integer  "view_per",                   default: 0, null: false
    t.integer  "market_iq_per",              default: 0, null: false
    t.integer  "stock_exchange_per",         default: 0, null: false
    t.integer  "profile_meter_per",          default: 0, null: false
    t.integer  "total_per",                  default: 0, null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "user_meters", ["user_id"], name: "index_user_meters_on_user_id", using: :btree

  create_table "user_percentages", force: :cascade do |t|
    t.integer  "parent_id"
    t.string   "ptype",      default: "", null: false
    t.string   "key",        default: "", null: false
    t.string   "value",      default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "user_percentages", ["parent_id"], name: "index_user_percentages_on_parent_id", using: :btree

  create_table "user_preferred_works", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "ind_name",              default: "",    null: false
    t.string   "functional_name",       default: "",    null: false
    t.string   "preferred_designation", default: "",    null: false
    t.string   "preferred_location",    default: "",    null: false
    t.string   "current_salary",        default: "",    null: false
    t.string   "expected_salary",       default: "",    null: false
    t.string   "time_type",             default: "",    null: false
    t.boolean  "active",                default: false
    t.datetime "created_at",                            null: false
    t.datetime "updated_at",                            null: false
  end

  add_index "user_preferred_works", ["user_id"], name: "index_user_preferred_works_on_user_id", using: :btree

  create_table "user_projects", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",       default: "", null: false
    t.string   "description", default: "", null: false
    t.string   "file",        default: ""
    t.string   "file_type",   default: "", null: false
    t.datetime "created_at",               null: false
    t.datetime "updated_at",               null: false
  end

  add_index "user_projects", ["user_id"], name: "index_user_projects_on_user_id", using: :btree

  create_table "user_rates", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "rate_id"
    t.integer  "rate_type",  default: 0, null: false
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_index "user_rates", ["user_id", "rate_id"], name: "index_user_rates_on_user_id_and_rate_id", using: :btree

  create_table "user_references", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",      default: "",           null: false
    t.string   "ref_type",   default: "",           null: false
    t.string   "from",       default: "",           null: false
    t.string   "email",      default: "",           null: false
    t.string   "contact",    default: "",           null: false
    t.date     "date",       default: '2016-11-21'
    t.string   "location",   default: "",           null: false
    t.string   "file",       default: ""
    t.string   "text_field", default: "",           null: false
    t.string   "file_type",  default: "",           null: false
    t.boolean  "active",     default: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "user_references", ["user_id"], name: "index_user_references_on_user_id", using: :btree

  create_table "user_shares", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "share_id"
    t.string   "share_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_shares", ["user_id", "share_id"], name: "index_user_shares_on_user_id_and_share_id", using: :btree

  create_table "user_views", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "view_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "user_views", ["user_id", "view_id"], name: "index_user_views_on_user_id_and_view_id", using: :btree

  create_table "user_whizquizzes", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "whizquiz_id"
    t.string   "text_field",  default: "",    null: false
    t.string   "review_type", default: "",    null: false
    t.string   "review",      default: ""
    t.boolean  "status",      default: false
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
  end

  add_index "user_whizquizzes", ["user_id"], name: "index_user_whizquizzes_on_user_id", using: :btree
  add_index "user_whizquizzes", ["whizquiz_id"], name: "index_user_whizquizzes_on_whizquiz_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "role",                                          default: 0,            null: false
    t.string   "title",                                         default: "",           null: false
    t.string   "email",                                         default: "",           null: false
    t.string   "username",                                      default: "",           null: false
    t.string   "first_name",                                    default: "",           null: false
    t.string   "middle_name",                                   default: "",           null: false
    t.string   "last_name",                                     default: "",           null: false
    t.string   "profile_pic",                                   default: ""
    t.string   "gender",                                        default: "",           null: false
    t.string   "date_of_birth",                                 default: "2016-11-21"
    t.string   "nationality",                                   default: "",           null: false
    t.string   "address",                                       default: "",           null: false
    t.string   "city",                                          default: "",           null: false
    t.integer  "country_id"
    t.string   "zipcode",                                       default: "",           null: false
    t.string   "contact_number",                                default: "",           null: false
    t.string   "file",                                          default: ""
    t.string   "text_field",                                    default: "",           null: false
    t.string   "file_type",                                     default: "",           null: false
    t.string   "faculty_work_with_type",                        default: "",           null: false
    t.string   "faculty_uni_name",                              default: "",           null: false
    t.string   "faculty_subject",                               default: "",           null: false
    t.string   "faculty_designation",                           default: "",           null: false
    t.string   "faculty_join_from",                             default: "2016-11-21"
    t.string   "company_name",                                  default: "",           null: false
    t.string   "company_establish_from",                        default: "",           null: false
    t.integer  "industry_id"
    t.string   "company_functional_area",                       default: "",           null: false
    t.string   "company_address",                               default: "",           null: false
    t.string   "company_zipcode",                               default: "",           null: false
    t.string   "company_city",                                  default: "",           null: false
    t.string   "company_contact",                               default: "",           null: false
    t.string   "company_skype_id",                              default: "",           null: false
    t.integer  "company_id"
    t.string   "company_logo",                                  default: ""
    t.string   "company_logo_type",                             default: "",           null: false
    t.string   "company_profile",                               default: ""
    t.string   "company_profile_type",                          default: "",           null: false
    t.string   "company_brochure",                              default: ""
    t.string   "company_brochure_type",                         default: "",           null: false
    t.string   "company_website",                               default: "",           null: false
    t.string   "company_facebook_link",                         default: "",           null: false
    t.string   "company_turnover",                              default: "",           null: false
    t.string   "company_no_of_emp",                             default: "",           null: false
    t.string   "company_growth_ratio",                          default: "",           null: false
    t.string   "company_new_ventures",                          default: "",           null: false
    t.string   "company_future_turnover",                       default: "",           null: false
    t.string   "company_future_new_venture_location",           default: "",           null: false
    t.string   "company_future_outlet",                         default: "",           null: false
    t.string   "delete_code",                                   default: "",           null: false
    t.integer  "user_total_per",                                default: 0,            null: false
    t.integer  "update_cv_count",                               default: 0,            null: false
    t.string   "back_profile",                                  default: ""
    t.boolean  "active",                                        default: true
    t.string   "encrypted_password",                            default: "",           null: false
    t.string   "reset_code",                          limit: 6
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                                 default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                           null: false
    t.datetime "updated_at",                                                           null: false
  end

  add_index "users", ["country_id"], name: "index_users_on_country_id", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  create_table "whizquizzes", force: :cascade do |t|
    t.string   "question",   default: "",    null: false
    t.string   "answer",     default: "",    null: false
    t.boolean  "status",     default: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_foreign_key "chats", "chat_schedules", on_delete: :cascade
  add_foreign_key "chats", "groups", on_delete: :cascade
  add_foreign_key "chats", "users", column: "sender_id", on_delete: :cascade
  add_foreign_key "company_galeries", "users", on_delete: :cascade
  add_foreign_key "devices", "users", on_delete: :cascade
  add_foreign_key "faculty_affiliations", "users", on_delete: :cascade
  add_foreign_key "faculty_publications", "users", on_delete: :cascade
  add_foreign_key "faculty_researches", "users", on_delete: :cascade
  add_foreign_key "faculty_workshops", "users", on_delete: :cascade
  add_foreign_key "graphs", "company_stocks", on_delete: :cascade
  add_foreign_key "graphs", "industries", on_delete: :cascade
  add_foreign_key "group_invitees", "groups", on_delete: :cascade
  add_foreign_key "group_users", "groups", on_delete: :cascade
  add_foreign_key "group_users", "users", on_delete: :cascade
  add_foreign_key "marketiqs", "industries", on_delete: :cascade
  add_foreign_key "marketiqs", "specializations", on_delete: :cascade
  add_foreign_key "student_educations", "users", on_delete: :cascade
  add_foreign_key "user_awards", "users", on_delete: :cascade
  add_foreign_key "user_certificates", "users", on_delete: :cascade
  add_foreign_key "user_curriculars", "users", on_delete: :cascade
  add_foreign_key "user_educations", "courses", on_delete: :cascade
  add_foreign_key "user_educations", "specializations", on_delete: :cascade
  add_foreign_key "user_educations", "users", on_delete: :cascade
  add_foreign_key "user_environments", "users", on_delete: :cascade
  add_foreign_key "user_experiences", "users", on_delete: :cascade
  add_foreign_key "user_favourites", "folders", on_delete: :cascade
  add_foreign_key "user_favourites", "users", column: "favourite_id", on_delete: :cascade
  add_foreign_key "user_favourites", "users", on_delete: :cascade
  add_foreign_key "user_folders", "folders", on_delete: :cascade
  add_foreign_key "user_folders", "users", on_delete: :cascade
  add_foreign_key "user_future_goals", "users", on_delete: :cascade
  add_foreign_key "user_likes", "users", column: "like_id", on_delete: :cascade
  add_foreign_key "user_likes", "users", on_delete: :cascade
  add_foreign_key "user_marketiqs", "marketiqs", on_delete: :cascade
  add_foreign_key "user_marketiqs", "users", on_delete: :cascade
  add_foreign_key "user_marksheets", "users", on_delete: :cascade
  add_foreign_key "user_meters", "users", on_delete: :cascade
  add_foreign_key "user_percentages", "user_percentages", column: "parent_id", on_delete: :cascade
  add_foreign_key "user_preferred_works", "users", on_delete: :cascade
  add_foreign_key "user_projects", "users", on_delete: :cascade
  add_foreign_key "user_rates", "users", column: "rate_id", on_delete: :cascade
  add_foreign_key "user_rates", "users", on_delete: :cascade
  add_foreign_key "user_references", "users", on_delete: :cascade
  add_foreign_key "user_shares", "users", column: "share_id", on_delete: :cascade
  add_foreign_key "user_shares", "users", on_delete: :cascade
  add_foreign_key "user_views", "users", column: "view_id", on_delete: :cascade
  add_foreign_key "user_views", "users", on_delete: :cascade
  add_foreign_key "user_whizquizzes", "users", on_delete: :cascade
  add_foreign_key "user_whizquizzes", "whizquizzes", on_delete: :cascade
  add_foreign_key "users", "company_stocks", column: "country_id", on_delete: :cascade
end

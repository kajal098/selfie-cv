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

ActiveRecord::Schema.define(version: 20160713065724) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "company_galeries", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "file",       default: ""
    t.string   "file_type",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "company_galeries", ["user_id"], name: "index_company_galeries_on_user_id", using: :btree

  create_table "courses", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "devices", force: :cascade do |t|
    t.integer  "user_id"
    t.uuid     "uuid"
    t.string   "registration_id"
    t.uuid     "token"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "devices", ["user_id"], name: "index_devices_on_user_id", using: :btree

  create_table "settings", id: false, force: :cascade do |t|
    t.string   "id"
    t.string   "value"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "specializations", force: :cascade do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  create_table "user_awards", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",        default: "",      null: false
    t.string   "award_type",  default: "award", null: false
    t.string   "description", default: "",      null: false
    t.string   "file",        default: ""
    t.string   "file_type",   default: "",      null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "user_awards", ["user_id"], name: "index_user_awards_on_user_id", using: :btree

  create_table "user_certificates", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "certificate_type", default: "", null: false
    t.string   "name",             default: "", null: false
    t.string   "year",             default: "", null: false
    t.string   "file",             default: ""
    t.string   "file_type",        default: "", null: false
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
  end

  add_index "user_certificates", ["user_id"], name: "index_user_certificates_on_user_id", using: :btree

  create_table "user_curriculars", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "curricular_type", default: "",           null: false
    t.string   "title",           default: "",           null: false
    t.string   "team_type",       default: "",           null: false
    t.string   "location",        default: "",           null: false
    t.date     "date",            default: '2016-07-13'
    t.string   "file",            default: ""
    t.string   "file_type",       default: "",           null: false
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
  end

  add_index "user_curriculars", ["user_id"], name: "index_user_curriculars_on_user_id", using: :btree

  create_table "user_educations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "specialization_id"
    t.string   "year",              default: "", null: false
    t.string   "school",            default: "", null: false
    t.string   "skill",             default: "", null: false
    t.datetime "created_at",                     null: false
    t.datetime "updated_at",                     null: false
  end

  add_index "user_educations", ["course_id"], name: "index_user_educations_on_course_id", using: :btree
  add_index "user_educations", ["specialization_id"], name: "index_user_educations_on_specialization_id", using: :btree
  add_index "user_educations", ["user_id"], name: "index_user_educations_on_user_id", using: :btree

  create_table "user_environments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "env_type",   default: "", null: false
    t.string   "title",      default: "", null: false
    t.string   "file",       default: ""
    t.string   "file_type",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "user_environments", ["user_id"], name: "index_user_environments_on_user_id", using: :btree

  create_table "user_experiences", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name",         default: "",           null: false
    t.string   "exp_type",     default: "",           null: false
    t.date     "start_from",   default: '2016-07-13'
    t.string   "working_till", default: "",           null: false
    t.string   "designation",  default: "",           null: false
    t.string   "file",         default: ""
    t.string   "file_type",    default: "",           null: false
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "user_experiences", ["user_id"], name: "index_user_experiences_on_user_id", using: :btree

  create_table "user_future_goals", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "goal_type",  default: "", null: false
    t.string   "title",      default: "", null: false
    t.string   "term_type",  default: "", null: false
    t.string   "file",       default: ""
    t.string   "file_type",  default: "", null: false
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
  end

  add_index "user_future_goals", ["user_id"], name: "index_user_future_goals_on_user_id", using: :btree

  create_table "user_meters", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "resume_per",     default: 0, null: false
    t.integer  "acievement_per", default: 0, null: false
    t.integer  "curri_per",      default: 0, null: false
    t.integer  "lifegoal_per",   default: 0, null: false
    t.integer  "working_per",    default: 0, null: false
    t.integer  "ref_per",        default: 0, null: false
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
  end

  add_index "user_meters", ["user_id"], name: "index_user_meters_on_user_id", using: :btree

  create_table "user_preferred_works", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "ind_name",              default: "", null: false
    t.string   "functional_name",       default: "", null: false
    t.string   "preferred_designation", default: "", null: false
    t.string   "preferred_location",    default: "", null: false
    t.string   "current_salary",        default: "", null: false
    t.string   "expected_salary",       default: "", null: false
    t.string   "time_type",             default: "", null: false
    t.datetime "created_at",                         null: false
    t.datetime "updated_at",                         null: false
  end

  add_index "user_preferred_works", ["user_id"], name: "index_user_preferred_works_on_user_id", using: :btree

  create_table "user_references", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title",      default: "",           null: false
    t.string   "ref_type",   default: "",           null: false
    t.string   "from",       default: "",           null: false
    t.string   "email",      default: "",           null: false
    t.string   "contact",    default: "",           null: false
    t.date     "date",       default: '2016-07-13'
    t.string   "location",   default: "",           null: false
    t.string   "file",       default: ""
    t.string   "file_type",  default: "",           null: false
    t.datetime "created_at",                        null: false
    t.datetime "updated_at",                        null: false
  end

  add_index "user_references", ["user_id"], name: "index_user_references_on_user_id", using: :btree

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
    t.string   "date_of_birth",                                 default: "2016-07-13"
    t.string   "nationality",                                   default: "",           null: false
    t.string   "address",                                       default: "",           null: false
    t.string   "city",                                          default: "",           null: false
    t.string   "zipcode",                                       default: "",           null: false
    t.string   "contact_number",                                default: "",           null: false
    t.string   "file",                                          default: ""
    t.string   "file_type",                                     default: "",           null: false
    t.string   "faculty_work_with_type",                        default: "",           null: false
    t.string   "faculty_uni_name",                              default: "",           null: false
    t.string   "faculty_subject",                               default: "",           null: false
    t.string   "faculty_designation",                           default: "",           null: false
    t.string   "faculty_join_from",                             default: "2016-07-13"
    t.string   "company_name",                                  default: "",           null: false
    t.string   "company_establish_from",                        default: "",           null: false
    t.string   "company_industry",                              default: "",           null: false
    t.string   "company_functional_area",                       default: "",           null: false
    t.string   "company_address",                               default: "",           null: false
    t.string   "company_zipcode",                               default: "",           null: false
    t.string   "company_city",                                  default: "",           null: false
    t.string   "company_contact",                               default: "",           null: false
    t.string   "company_skype_id",                              default: "",           null: false
    t.string   "company_id",                                    default: "",           null: false
    t.string   "company_logo",                                  default: ""
    t.string   "company_profile",                               default: ""
    t.string   "company_brochure",                              default: ""
    t.string   "company_website",                               default: "",           null: false
    t.string   "company_facebook_link",                         default: "",           null: false
    t.string   "company_turnover",                              default: "",           null: false
    t.string   "company_no_of_emp",                             default: "",           null: false
    t.string   "company_growth_ratio",                          default: "",           null: false
    t.string   "company_new_ventures",                          default: "",           null: false
    t.string   "company_future_turnover",                       default: "",           null: false
    t.string   "company_future_new_venture_location",           default: "",           null: false
    t.string   "company_future_outlet",                         default: "",           null: false
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

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "company_galeries", "users", on_delete: :cascade
  add_foreign_key "devices", "users", on_delete: :cascade
  add_foreign_key "user_awards", "users", on_delete: :cascade
  add_foreign_key "user_certificates", "users", on_delete: :cascade
  add_foreign_key "user_curriculars", "users", on_delete: :cascade
  add_foreign_key "user_educations", "courses", on_delete: :cascade
  add_foreign_key "user_educations", "specializations", on_delete: :cascade
  add_foreign_key "user_educations", "users", on_delete: :cascade
  add_foreign_key "user_environments", "users", on_delete: :cascade
  add_foreign_key "user_experiences", "users", on_delete: :cascade
  add_foreign_key "user_future_goals", "users", on_delete: :cascade
  add_foreign_key "user_meters", "users", on_delete: :cascade
  add_foreign_key "user_preferred_works", "users", on_delete: :cascade
  add_foreign_key "user_references", "users", on_delete: :cascade
end

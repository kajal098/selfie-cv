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

ActiveRecord::Schema.define(version: 20160701095907) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "courses", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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

  create_table "specializations", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_educations", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "course_id"
    t.integer  "specialization_id"
    t.string   "year"
    t.string   "school"
    t.string   "skill"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "user_educations", ["course_id"], name: "index_user_educations_on_course_id", using: :btree
  add_index "user_educations", ["specialization_id"], name: "index_user_educations_on_specialization_id", using: :btree
  add_index "user_educations", ["user_id"], name: "index_user_educations_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.integer  "role",                                  default: 0,            null: false
    t.string   "title",                                 default: "",           null: false
    t.string   "email",                                 default: "",           null: false
    t.string   "username",                              default: "",           null: false
    t.string   "first_name",                            default: "",           null: false
    t.string   "middle_name",                           default: "",           null: false
    t.string   "last_name",                             default: "",           null: false
    t.string   "profile_pic",                           default: ""
    t.string   "gender",                                default: "",           null: false
    t.string   "date_of_birth",                         default: "2016-07-01"
    t.string   "nationality",                           default: "",           null: false
    t.string   "address",                               default: "",           null: false
    t.string   "city",                                  default: "",           null: false
    t.string   "contact_number",                        default: "",           null: false
    t.string   "education_in",                          default: "",           null: false
    t.string   "school_name",                           default: "",           null: false
    t.string   "year"
    t.string   "file",                                  default: ""
    t.string   "faculty_work_with_type",                default: "",           null: false
    t.string   "faculty_uni_name",                      default: "",           null: false
    t.string   "faculty_subject",                       default: "",           null: false
    t.string   "faculty_designation",                   default: "",           null: false
    t.string   "faculty_join_from",                     default: "2016-07-01"
    t.string   "company_name",                          default: "",           null: false
    t.string   "establish_from",                        default: "2016-07-01"
    t.string   "industry_type",                         default: "",           null: false
    t.string   "functional_area",                       default: "",           null: false
    t.string   "company_address",                       default: "",           null: false
    t.string   "company_zipcode",                       default: "",           null: false
    t.string   "company_city",                          default: "",           null: false
    t.string   "company_contact",                       default: "",           null: false
    t.string   "company_skype_id",                      default: "",           null: false
    t.string   "company_id",                            default: "",           null: false
    t.string   "company_logo",                          default: ""
    t.string   "company_profile",                       default: ""
    t.string   "company_brochure",                      default: ""
    t.string   "company_website",                       default: "",           null: false
    t.string   "company_facebook_link",                 default: "",           null: false
    t.string   "company_turnover",                      default: "",           null: false
    t.string   "company_emp",                           default: "",           null: false
    t.string   "company_growth",                        default: "",           null: false
    t.string   "companu_new_ventures",                  default: "",           null: false
    t.string   "company_future_turnover",               default: "",           null: false
    t.string   "company_future_new_ventures",           default: "",           null: false
    t.string   "company_future_outlet",                 default: "",           null: false
    t.string   "encrypted_password",                    default: "",           null: false
    t.string   "reset_code",                  limit: 6
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                         default: 0,            null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                                   null: false
    t.datetime "updated_at",                                                   null: false
  end

  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "devices", "users", on_delete: :cascade
  add_foreign_key "user_educations", "courses", on_delete: :cascade
  add_foreign_key "user_educations", "specializations", on_delete: :cascade
  add_foreign_key "user_educations", "users", on_delete: :cascade
end

class CreateUserMeters < ActiveRecord::Migration
  def change
    create_table :user_meters do |t|
      
      t.integer :user_id

      t.integer :resume_per,              null:false, default: 0
      t.integer :resume_info_per,              null:false, default: 0
      t.integer :education_per,              null:false, default: 0
      t.integer :experience_per,              null:false, default: 0
      t.integer :prework_per,              null:false, default: 0
      t.integer :achievement_per,              null:false, default: 0
      t.integer :award_per,              null:false, default: 0
      t.integer :certificate_per,              null:false, default: 0
      t.integer :curri_per,              null:false, default: 0
      t.integer :whizquiz_per,              null:false, default: 0
      t.integer :future_goal_per,              null:false, default: 0
      t.integer :working_env_per,              null:false, default: 0
      t.integer :ref_per,              null:false, default: 0
      
      t.integer :company_info_per,        null:false, default: 0
      t.integer :corporate_identity_per,        null:false, default: 0
      t.integer :growth_and_goal_per,        null:false, default: 0
      t.integer :evalution_per,        null:false, default: 0
      t.integer :galery_per,        null:false, default: 0
      
      t.integer :student_basic_info_per,        null:false, default: 0
      t.integer :student_education_per,        null:false, default: 0
      t.integer :student_education_info_per,        null:false, default: 0
      t.integer :student_marksheet_per,        null:false, default: 0
      t.integer :student_project_per,        null:false, default: 0
      
      t.integer :faculty_basic_info_per,        null:false, default: 0
      t.integer :faculty_affiliation_per,        null:false, default: 0
      t.integer :faculty_workshop_per,        null:false, default: 0
      t.integer :faculty_publication_per,        null:false, default: 0
      t.integer :faculty_research_per,        null:false, default: 0

      t.integer :like_per,        null:false, default: 0
      t.integer :rate_per,        null:false, default: 0
      t.integer :update_info_per,        null:false, default: 0
      t.integer :share_per,        null:false, default: 0 
      t.integer :view_per,        null:false, default: 0
      t.integer :market_iq_per,        null:false, default: 0
      t.integer :stock_exchange_per,        null:false, default: 0
      t.integer :profile_meter_per,        null:false, default: 0
      t.integer :total_per,        null:false, default: 0

      t.timestamps null: false

    end
    add_index :user_meters, [:user_id]
    add_foreign_key :user_meters, :users, on_delete: :cascade
  end
end

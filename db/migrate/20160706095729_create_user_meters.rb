class CreateUserMeters < ActiveRecord::Migration
  def change
    create_table :user_meters do |t|
      t.integer :user_id
      t.integer :resume_per,              null:false, default: 0
      t.integer :achievement_per,              null:false, default: 0
      t.integer :curri_per,              null:false, default: 0
      t.integer :lifegoal_per,              null:false, default: 0
      t.integer :working_per,              null:false, default: 0
      t.integer :ref_per,              null:false, default: 0
      t.integer :whizquiz_per,              null:false, default: 0
      t.integer :company_info_per,        null:false, default: 0
      t.integer :corporate_identity_per,        null:false, default: 0
      t.integer :growth_and_goal_per,        null:false, default: 0
      t.integer :company_tribute_per,        null:false, default: 0
      t.integer :galery_per,        null:false, default: 0
      t.integer :working_env_per,        null:false, default: 0
      t.integer :student_basic_info_per,        null:false, default: 0
      t.integer :student_education_per,        null:false, default: 0
      t.integer :student_achievement_per,        null:false, default: 0
      t.integer :student_extra_curri_per,        null:false, default: 0
      t.integer :faculty_basic_info_per,        null:false, default: 0
      t.integer :faculty_experience_per,        null:false, default: 0
      t.integer :faculty_achievement_per,        null:false, default: 0
      t.timestamps null: false
    end
    add_index :user_meters, [:user_id]
    add_foreign_key :user_meters, :users, on_delete: :cascade
  end
end

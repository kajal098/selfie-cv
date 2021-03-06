class CreateUserEducations < ActiveRecord::Migration
  def change
    create_table :user_educations do |t|
      t.integer :user_id
      t.integer :course_id
      t.integer :specialization_id
      t.string :year,              null: false, default: ""
      t.string :school,              null: false, default: ""
      t.string :skill,              null: false, default: ""
      t.boolean :active,            default: false
      t.timestamps null: false
    end
    add_index :user_educations, [:user_id]
    add_foreign_key :user_educations, :users, on_delete: :cascade
    add_index :user_educations, [:course_id]
    add_foreign_key :user_educations, :courses, on_delete: :cascade
    add_index :user_educations, [:specialization_id]
    add_foreign_key :user_educations, :specializations, on_delete: :cascade
  end
end

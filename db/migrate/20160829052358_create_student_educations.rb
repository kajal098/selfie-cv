class CreateStudentEducations < ActiveRecord::Migration
  def change
    create_table :student_educations do |t|
      t.integer :user_id
      t.string :standard
      t.string :year,              null: false, default: ""
      t.string :school,              null: false, default: ""
      t.timestamps null: false
    end
    add_index :student_educations, [:user_id]
    add_foreign_key :student_educations, :users, on_delete: :cascade
  end
end

class CreateFacultyWorkshops < ActiveRecord::Migration
  def change
    create_table :faculty_workshops do |t|
      t.integer :user_id
      t.string :description,              null:false, default: ""

      t.timestamps null: false
    end
    add_index :faculty_workshops, [:user_id]
    add_foreign_key :faculty_workshops, :users, on_delete: :cascade
  end
end

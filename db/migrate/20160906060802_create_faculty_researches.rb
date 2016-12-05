class CreateFacultyResearches < ActiveRecord::Migration
  def change
    create_table :faculty_researches do |t|
      t.integer :user_id
      t.string :title,              null:false, default: ""
      t.string :description,              null:false, default: ""
      t.string :file,              default: ''
      t.string :file_type,              null:false, default: ""
      t.timestamps null: false
    end
    add_index :faculty_researches, [:user_id]
    add_foreign_key :faculty_researches, :users, on_delete: :cascade
  end
end

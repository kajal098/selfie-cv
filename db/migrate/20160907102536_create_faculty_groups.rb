class CreateFacultyGroups < ActiveRecord::Migration
  def change
    create_table :faculty_groups do |t|
    	t.integer :user_id
      	t.string :name,              null: false, default: ""
      	t.integer :code,              null: false, default: ""

      t.timestamps null: false
    end
    add_index :faculty_groups, [:user_id]
    add_foreign_key :faculty_groups, :users, on_delete: :cascade
  end
end

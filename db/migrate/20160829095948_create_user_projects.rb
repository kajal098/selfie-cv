class CreateUserProjects < ActiveRecord::Migration
  def change
    create_table :user_projects do |t|
      t.integer :user_id
      t.string :title,              null: false, default: ""
      t.string :description,              null: false, default: ""
      t.timestamps null: false
    end
    add_index :user_projects, [:user_id]
    add_foreign_key :user_projects, :users, on_delete: :cascade
  end
end

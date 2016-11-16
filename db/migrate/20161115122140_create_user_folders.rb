class CreateUserFolders < ActiveRecord::Migration
  def change
    create_table :user_folders do |t|
      t.integer :user_id
      t.integer :folder_id
      t.timestamps null: false
    end
    add_index :user_folders, [:user_id]
    add_foreign_key :user_folders, :users, on_delete: :cascade
    add_index :user_folders, [:folder_id]
    add_foreign_key :user_folders, :folders, on_delete: :cascade
  end
end

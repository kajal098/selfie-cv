class CreateUserEnvironments < ActiveRecord::Migration
  def change
    create_table :user_environments do |t|
      t.integer :user_id
      t.string :env_type,              null: false, default: ""
      t.string :title,              null: false, default: ""
      t.string :file,              default: ''
      t.string :file_type,              null: false, default: ""
      t.boolean :active,            default: false
      t.timestamps null: false
    end
    add_index :user_environments, [:user_id]
    add_foreign_key :user_environments, :users, on_delete: :cascade
  end
end

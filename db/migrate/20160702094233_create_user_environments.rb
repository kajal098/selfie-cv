class CreateUserEnvironments < ActiveRecord::Migration
  def change
    create_table :user_environments do |t|
      t.integer :user_id
      t.string :env_type
      t.string :title
      t.string :file

      t.timestamps null: false
    end
    add_index :user_environments, [:user_id]
    add_foreign_key :user_environments, :users, on_delete: :cascade
  end
end

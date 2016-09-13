class CreateGroupUsers < ActiveRecord::Migration
  def change
    create_table :group_users do |t|
    	  t.integer :group_id, null: false
        t.integer :user_id, null: false
        t.boolean :admin, default: false
        t.integer :status
        t.integer :leaved_from, array: true, default: []
        t.timestamps null: false
    end
    add_index :group_users, [:user_id]
    add_foreign_key :group_users, :users, on_delete: :cascade
    add_index :group_users, [:group_id]
    add_foreign_key :group_users, :groups, on_delete: :cascade
  end
end

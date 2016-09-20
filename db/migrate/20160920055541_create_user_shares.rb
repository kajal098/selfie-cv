class CreateUserShares < ActiveRecord::Migration
  def change
    create_table :user_shares do |t|
      t.integer :user_id
      t.integer :share_id
      t.string  :share_type

      t.timestamps null: false
    end
    add_index :user_shares, [:user_id, :share_id]
    add_foreign_key :user_shares, :users, on_delete: :cascade
    add_foreign_key :user_shares, :users, column: :share_id, on_delete: :cascade
  end
end

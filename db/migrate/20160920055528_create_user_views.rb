class CreateUserViews < ActiveRecord::Migration
  def change
    create_table :user_views do |t|
      t.integer :user_id
      t.integer :view_id
      t.timestamps null: false
    end
    add_index :user_views, [:user_id, :view_id]
    add_foreign_key :user_views, :users, on_delete: :cascade
    add_foreign_key :user_views, :users, column: :view_id, on_delete: :cascade
  end
end

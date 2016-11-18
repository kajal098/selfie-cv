class CreateUserLikes < ActiveRecord::Migration
  def change
    create_table :user_likes do |t|
      t.integer :user_id
      t.integer :like_id
      t.boolean :is_liked, default:false
      t.timestamps null: false
    end
    add_index :user_likes, [:user_id, :like_id]
    add_foreign_key :user_likes, :users, on_delete: :cascade
    add_foreign_key :user_likes, :users, column: :like_id, on_delete: :cascade
  end
end

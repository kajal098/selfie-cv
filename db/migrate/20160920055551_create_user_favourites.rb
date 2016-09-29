class CreateUserFavourites < ActiveRecord::Migration
  def change
    create_table :user_favourites do |t|
      t.integer :user_id
      t.integer :favourite_id
      t.boolean :is_favourited, default:false

      t.timestamps null: false
    end
    add_index :user_favourites, [:user_id, :favourite_id]
    add_foreign_key :user_favourites, :users, on_delete: :cascade
    add_foreign_key :user_favourites, :users, column: :favourite_id, on_delete: :cascade
  end
end

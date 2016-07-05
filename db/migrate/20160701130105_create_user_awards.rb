class CreateUserAwards < ActiveRecord::Migration
  def change
    create_table :user_awards do |t|
      t.integer :user_id
      t.string :name,              null: false, default: ""
      t.string :award_type,              null: false, default: "award"
      t.string :description,              null: false, default: ""
      t.string :file,              default: ''
      t.timestamps null: false
    end
    add_index :user_awards, [:user_id]
    add_foreign_key :user_awards, :users, on_delete: :cascade
  end
end

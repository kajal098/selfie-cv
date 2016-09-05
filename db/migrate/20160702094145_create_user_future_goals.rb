class CreateUserFutureGoals < ActiveRecord::Migration
  def change
    create_table :user_future_goals do |t|
      t.integer :user_id
      t.string :goal_type,              null: false, default: ""
      t.string :title,              null: false, default: ""
      t.string :term_type,              null: false, default: ""
      t.string :file,              default: ''
      t.string :text_field,              null: false, default: ""
      t.string :file_type,              null: false, default: ""
      t.boolean :active,            default: false
      t.timestamps null: false
    end
    add_index :user_future_goals, [:user_id]
    add_foreign_key :user_future_goals, :users, on_delete: :cascade
  end
end

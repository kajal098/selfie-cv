class CreateUserFutureGoals < ActiveRecord::Migration
  def change
    create_table :user_future_goals do |t|
      t.integer :user_id
      t.string :goal_type
      t.string :title
      t.string :term_type
      t.string :file

      t.timestamps null: false
    end
    add_index :user_future_goals, [:user_id]
    add_foreign_key :user_future_goals, :users, on_delete: :cascade
  end
end

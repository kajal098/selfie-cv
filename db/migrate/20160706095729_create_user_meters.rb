class CreateUserMeters < ActiveRecord::Migration
  def change
    create_table :user_meters do |t|
      t.integer :user_id
      t.integer :resume_per,              null:false, default: 0
      t.integer :acievement_per,              null:false, default: 0
      t.integer :curri_per,              null:false, default: 0
      t.integer :lifegoal_per,              null:false, default: 0
      t.integer :working_per,              null:false, default: 0
      t.integer :ref_per,              null:false, default: 0
      t.timestamps null: false
    end
    add_index :user_meters, [:user_id]
    add_foreign_key :user_meters, :users, on_delete: :cascade
  end
end

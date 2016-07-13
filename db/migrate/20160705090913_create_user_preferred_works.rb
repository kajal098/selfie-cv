class CreateUserPreferredWorks < ActiveRecord::Migration
  def change
    create_table :user_preferred_works do |t|
      t.integer :user_id
      t.string :ind_name,              null:false, default: ""
      t.string :functional_name,              null:false, default: ""
      t.string :preferred_designation,              null:false, default: ""
      t.string :preferred_location,              null:false, default: ""
      t.string :current_salary,              null:false, default: ""
      t.string :expected_salary,              null:false, default: ""
      t.string :time_type,              null:false, default: ""
      t.boolean :active,            default: false
      t.timestamps null: false
    end
    add_index :user_preferred_works, [:user_id]
    add_foreign_key :user_preferred_works, :users, on_delete: :cascade
  end
end

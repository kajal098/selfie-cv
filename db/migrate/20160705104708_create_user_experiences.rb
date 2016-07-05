class CreateUserExperiences < ActiveRecord::Migration
  def change
    create_table :user_experiences do |t|
      t.integer :user_id
      t.string :name,              null:false, default: ""
      t.string :type,              null:false, default: ""
      t.date :start_from,              :default=>Date.today
      t.string :working_till,              null:false, default: ""
      t.string :designation,              null:false, default: ""
      t.string :file,              default: ''

      t.timestamps null: false
    end
    add_index :user_experiences, [:user_id]
    add_foreign_key :user_experiences, :users, on_delete: :cascade
  end
end

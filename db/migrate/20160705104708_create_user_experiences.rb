class CreateUserExperiences < ActiveRecord::Migration
  def change
    create_table :user_experiences do |t|
      t.integer :user_id
      t.string :name,              null:false, default: ""
      t.string :exp_type,           null:false, default: ""
      t.date :start_from,              :default=>Date.today
      t.date :working_till,              :default=>Date.today
      t.string :designation,              null:false, default: ""
      t.string :description,              null:false, default: ""
      t.string :file,              default: ''
      t.string :file_type,              null: false, default: ""
      t.string :file_status,              null: false, default: :true
      t.boolean :active,            default: false
      t.boolean :current_company,            default: false
      t.timestamps null: false
    end
    add_index :user_experiences, [:user_id]
    add_foreign_key :user_experiences, :users, on_delete: :cascade
  end
end

class CreateUserCurriculars < ActiveRecord::Migration
  def change
    create_table :user_curriculars do |t|
      t.integer :user_id
      t.string :curricular_type,              null: false, default: ""
      t.string :title,              null: false, default: ""
      t.string :team_type,              null: false, default: ""
      t.string :location,              null: false, default: ""
      t.date :date,                   :default=> Date.today
      t.string :file,                 default: ''
      t.string :file_type,              null: false, default: ""
      t.timestamps null: false
    end
    add_index :user_curriculars, [:user_id]
    add_foreign_key :user_curriculars, :users, on_delete: :cascade
  end
end

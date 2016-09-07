class CreateFacultyAffiliations < ActiveRecord::Migration
  def change
    create_table :faculty_affiliations do |t|
      t.integer :user_id
      t.boolean :university,               default: false
      t.string :collage_name,              null:false, default: ""
      t.string :subject,              null:false, default: ""
      t.string :designation,              null:false, default: ""
      t.date :join_from,                  :default=>Date.today
      
      t.timestamps null: false
    end
    add_index :faculty_affiliations, [:user_id]
    add_foreign_key :faculty_affiliations, :users, on_delete: :cascade
  end
end

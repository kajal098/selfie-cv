class CreateUserMarksheets < ActiveRecord::Migration
  def change
    create_table :user_marksheets do |t|
      t.integer :user_id
      t.string :school_name,              null:false, default: ""
      t.string :standard,              null:false, default: ""
      t.string :grade,              null:false, default: ""
      t.string :year,              null:false, default: ""
      t.string :file,              default: ''
      t.string :file_type,              null:false, default: ""
      t.string :file_status,              null: false, default: :true
      t.timestamps null: false
    end
    add_index :user_marksheets, [:user_id]
    add_foreign_key :user_marksheets, :users, on_delete: :cascade
  end
end

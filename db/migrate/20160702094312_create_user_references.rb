class CreateUserReferences < ActiveRecord::Migration
  def change
    create_table :user_references do |t|
      t.integer :user_id
      t.string :title,              null: false, default: ""
      t.string :ref_type,              null: false, default: ""
      t.string :from,              null: false, default: ""
      t.string :email,              null: false, default: ""
      t.string :contact,              null: false, default: ""
      t.date   :date,                  :default=>Date.today
      t.string :location,              null: false, default: ""
      t.string :file,              default: ''
      t.string :text_field,              null: false, default: ""
      t.string :file_type,              null: false, default: ""
      t.string :file_status,              null: false, default: :true
      t.boolean :active,            default: false
      t.timestamps null: false
    end
    add_index :user_references, [:user_id]
    add_foreign_key :user_references, :users, on_delete: :cascade
  end
end

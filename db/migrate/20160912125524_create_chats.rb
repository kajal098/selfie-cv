class CreateChats < ActiveRecord::Migration
  def change
    create_table :chats do |t|
      t.integer :sender_id
      t.integer :group_id
      t.string :quick_msg,              null: false, default: ""
      t.boolean :activity,            default: false
      t.string :file,              default: ''
      t.string :file_type,              null:false, default: ""
      t.integer :user_ids, array: true, default: []

      t.timestamps null: false
    end
    add_index :chats, [:sender_id]
    add_foreign_key :chats, :users, column: :sender_id, on_delete: :cascade
    add_index :chats, [:group_id]
    add_foreign_key :chats, :groups, on_delete: :cascade
  end
end

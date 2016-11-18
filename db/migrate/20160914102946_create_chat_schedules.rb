class CreateChatSchedules < ActiveRecord::Migration
  def change
    create_table :chat_schedules do |t|
      t.string :name,              null: false, default: ""
      t.date :date, array: true, default: []
      t.string :my_time, array: true, default: []
      t.string :description, array: true, default: []
      t.string :info,              null: false, default: ""
      t.integer :group_id, array: true, default: []
      t.timestamps null: false
    end
    end
end

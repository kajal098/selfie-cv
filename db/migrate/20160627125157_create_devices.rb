class CreateDevices < ActiveRecord::Migration
  def change
    create_table :devices do |t|
      t.integer :user_id
      t.string :uuid
      t.string :registration_id
      t.uuid :token
      t.string :device_type

      t.timestamps null: false
    end
    add_index :devices, [:user_id]
    add_foreign_key :devices, :users, on_delete: :cascade
  end
end

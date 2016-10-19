class CreateUserMarketiqs < ActiveRecord::Migration
  def change
    create_table :user_marketiqs do |t|
    	t.integer  :user_id
    	t.integer  :marketiq_id
    	t.string  :answer,              null:false, default: ""
    	t.boolean  :status,            default: false
    	t.timestamps null: false
    end
    add_index :user_marketiqs, [:user_id]
    add_foreign_key :user_marketiqs, :users, on_delete: :cascade
    add_index :user_marketiqs, [:marketiq_id]
    add_foreign_key :user_marketiqs, :marketiqs, on_delete: :cascade
  end
end

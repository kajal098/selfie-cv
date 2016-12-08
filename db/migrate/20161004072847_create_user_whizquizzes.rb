class CreateUserWhizquizzes < ActiveRecord::Migration
  def change
    create_table :user_whizquizzes do |t|
    	t.integer :user_id
    	t.integer :whizquiz_id
      t.string  :text_field,              null:false, default: ""
    	t.string  :review_type,              null:false, default: ""
      t.string  :review,              default: ''
      t.string  :review_status,              null: false, default: ""
    	t.boolean :status,            default: false  	
      t.timestamps null: false
    end
    add_index :user_whizquizzes, [:user_id]
    add_foreign_key :user_whizquizzes, :users, on_delete: :cascade
    add_index :user_whizquizzes, [:whizquiz_id]
    add_foreign_key :user_whizquizzes, :whizquizzes, on_delete: :cascade
  end
end

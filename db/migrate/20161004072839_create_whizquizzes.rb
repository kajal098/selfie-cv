class CreateWhizquizzes < ActiveRecord::Migration
  def change
    create_table :whizquizzes do |t|
    	t.string  :question,              null:false, default: ""
    	t.string  :answer,              null:false, default: ""
    	t.boolean :active,            default: false

      t.timestamps null: false
    end
  end
end

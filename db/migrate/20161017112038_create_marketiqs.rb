class CreateMarketiqs < ActiveRecord::Migration
  def change
    create_table :marketiqs do |t|

      t.integer  :category_id
    	t.string  :question,              null:false, default: ""
    	t.string  :option_a,              null:false, default: ""
    	t.string  :option_b,              null:false, default: ""
    	t.string  :option_c,              null:false, default: ""
    	t.string  :option_d,              null:false, default: ""
    	t.string  :answer,              null:false, default: ""

      t.timestamps null: false
    end
    add_index :marketiqs, [:category_id]
    add_foreign_key :marketiqs, :categories, on_delete: :cascade
  end
end

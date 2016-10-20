class CreateMarketiqs < ActiveRecord::Migration
  def change
    create_table :marketiqs do |t|

      t.integer  :industry_id
      t.integer  :specialization_id
    	t.string  :question,              null:false, default: ""
    	t.string  :option_a,              null:false, default: ""
    	t.string  :option_b,              null:false, default: ""
    	t.string  :option_c,              null:false, default: ""
    	t.string  :option_d,              null:false, default: ""
    	t.string  :answer,                null:false, default: ""
      t.boolean :role,                  default: false

      t.timestamps null: false
    end
    add_index :marketiqs, [:industry_id]
    add_foreign_key :marketiqs, :industries, on_delete: :cascade
    add_index :marketiqs, [:specialization_id]
    add_foreign_key :marketiqs, :specializations, on_delete: :cascade
  end
end

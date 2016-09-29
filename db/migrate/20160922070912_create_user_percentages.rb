class CreateUserPercentages < ActiveRecord::Migration
  def change
    create_table :user_percentages do |t|
      t.integer :parent_id
      t.string :ptype, null:false, default: ""
      t.string :key, null:false, default: ""
      t.string :value, null:false, default: ""
      t.timestamps null: false
    end
    add_index :user_percentages, [:parent_id]
    add_foreign_key :user_percentages, :user_percentages, column: :parent_id, on_delete: :cascade
  end
end

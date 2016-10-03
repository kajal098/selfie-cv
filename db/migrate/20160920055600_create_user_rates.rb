class CreateUserRates < ActiveRecord::Migration
  def change
    create_table :user_rates do |t|
      t.integer :user_id
      t.integer :rate_id
      t.integer  :rate_type,              null: false, default: 0

      t.timestamps null: false
    end
    add_index :user_rates, [:user_id, :rate_id]
    add_foreign_key :user_rates, :users, on_delete: :cascade
    add_foreign_key :user_rates, :users, column: :rate_id, on_delete: :cascade
  end
end

class CreateGraphs < ActiveRecord::Migration
  def change
    create_table :graphs do |t|
    	t.integer :company_stock_id
    	t.integer :industry_id
    	t.string  :company_code

      t.timestamps null: false
    end
    add_index :graphs, [:company_stock_id]
    add_foreign_key :graphs, :company_stocks, on_delete: :cascade
    add_index :graphs, [:industry_id]
    add_foreign_key :graphs, :industries, on_delete: :cascade
  end
end
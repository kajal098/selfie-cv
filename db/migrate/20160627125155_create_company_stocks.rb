class CreateCompanyStocks < ActiveRecord::Migration
  def change
    create_table :company_stocks do |t|
    	t.string  :sensex_co,              null:false, default: ""
    	t.integer :category_id
    	t.string  :sensex,              null:false, default: ""
    	t.string  :currency,              null:false, default: ""
    	t.string  :date_format,              null:false, default: "dd/mm/yyyy"
        t.timestamps null: false
    end
    add_index :company_stocks, [:category_id]
    add_foreign_key :company_stocks, :categories, on_delete: :cascade
  end
end

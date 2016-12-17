class CreateCompanyStocks < ActiveRecord::Migration
  def change
    create_table :company_stocks do |t|
    	t.integer  :stock_country_id
    	t.integer :category_id
        t.string  :company_code,              null:false, default: ""
    	t.string  :sensex,              null:false, default: ""
    	t.string  :currency,              null:false, default: ""
    	t.string  :date_format,              null:false, default: "dd/mm/yyyy"
        t.string  :start_time,              :default => Time.zone.now      
        t.timestamps null: false
    end
    add_index :company_stocks, [:category_id]
    add_foreign_key :company_stocks, :categories, on_delete: :cascade
    add_index :company_stocks, [:stock_country_id]
    add_foreign_key :company_stocks, :stock_countries, on_delete: :cascade
  end
end

class CreateCompanyStocks < ActiveRecord::Migration
  def change
    create_table :company_stocks do |t|
    	t.string  :sensex_co,              null:false, default: ""
    	t.string  :sensex,              null:false, default: ""
    	t.string  :currency,              null:false, default: ""
    	t.string  :date_format,              null:false, default: ""
        t.timestamps null: false
    end
  end
end

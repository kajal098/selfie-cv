class CreateStockCountries < ActiveRecord::Migration
  def change
    create_table :stock_countries do |t|
      t.string :name,              null: false, default: ""
      t.string  :date_format,              null:false, default: "dd/mm/yyyy"
      t.timestamps null: false
    end
  end
end

class CreateStockCountries < ActiveRecord::Migration
  def change
    create_table :stock_countries do |t|
      t.string :name,              null: false, default: ""
      t.string  :date_format,              null:false, default: "dd/mm/yyyy"
      t.datetime :start_time,           :default => Time.now
      t.datetime :end_time,           :default => Time.now
      t.timestamps null: false
    end
  end
end

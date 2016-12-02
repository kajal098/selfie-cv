class CreateStockCountries < ActiveRecord::Migration
  def change
    create_table :stock_countries do |t|
      t.string :name,              null: false, default: ""
      t.timestamps null: false
    end
  end
end

class AddDateFormatToStockCountries < ActiveRecord::Migration
  def change
    add_column :stock_countries, :date_format, :string
  end
end

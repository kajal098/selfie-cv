json.array!(@company_stocks) do |company_stock|
  json.extract! company_stock, :stock_country_id, :company_code, :sensex, :currency, :date_format, :start_time
  json.url company_stock_url(company_stock, format: :json)
end
json.array!(@company_stocks) do |company_stock|
  json.extract! company_stock, :sensex_co, :sensex, :currency, :date_format
  json.url company_stock_url(company_stock, format: :json)
end
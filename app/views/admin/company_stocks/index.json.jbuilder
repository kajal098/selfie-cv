json.array!(@company_stocks) do |company_stock|
  json.extract! company_stock, :country, :sensex, :currency
  json.url company_stock_url(company_stock, format: :json)
end
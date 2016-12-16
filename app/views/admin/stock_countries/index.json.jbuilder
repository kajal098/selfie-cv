json.array!(@stock_countries) do |stock_country|
  json.extract! stock_country, :name, :date_format
  json.url stock_country_url(stock_country, format: :json)
end
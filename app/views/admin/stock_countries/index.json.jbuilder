json.array!(@stock_countries) do |stock_country|
  json.extract! stock_country, :question, :option_a, :option_b, :option_c, option_d, :answer
  json.url stock_country_url(stock_country, format: :json)
end
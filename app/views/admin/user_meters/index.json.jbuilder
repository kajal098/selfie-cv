json.array!(@user_meters) do |user_meter|
  json.extract! user_meter, :name
  json.url user_meter_url(user_meter, format: :json)
end
json.array!(@specializations) do |specialization|
  json.extract! specialization, :name
  json.url specialization_url(specialization, format: :json)
end
json.array!(@graphs) do |graph|
  json.extract! graph, :company_code
  json.url graph_url(graph, format: :json)
end
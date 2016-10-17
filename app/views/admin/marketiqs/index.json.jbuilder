json.array!(@marketiqs) do |marketiq|
  json.extract! marketiq, :question, :option_a, :option_b, :option_c, option_d, :answer
  json.url marketiq_url(marketiq, format: :json)
end
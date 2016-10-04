json.array!(@whizquizzes) do |whizquiz|
  json.extract! whizquiz, :question
  json.url whizquiz_url(whizquiz, format: :json)
end
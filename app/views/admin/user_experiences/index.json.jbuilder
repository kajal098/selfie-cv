json.array!(@user_experiences) do |user_experience|
  json.extract! user_experience, :year
  json.url user_experience_url(user_experience, format: :json)
end
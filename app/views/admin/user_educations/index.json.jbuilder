json.array!(@user_educations) do |user_education|
  json.extract! user_education, :year
  json.url user_education_url(user_education, format: :json)
end
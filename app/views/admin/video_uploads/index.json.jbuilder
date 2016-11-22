json.array!(@video_uploads) do |user|
  json.extract! user, :file
  json.url user_url(user, format: :json)
end
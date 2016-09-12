json.array!(@quick_messages) do |quick_message|
  json.extract! quick_message, :text
  json.url quick_message_url(quick_message, format: :json)
end
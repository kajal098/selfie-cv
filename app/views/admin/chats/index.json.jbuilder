json.array!(@chats) do |chat|
  json.extract! chat, :name
  json.url chat_url(chat, format: :json)
end
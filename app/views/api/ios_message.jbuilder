if @messages
	json.messages @messages do |message|
		json.extract! message, :id, :text, :role
		json.message_created_at message.created_at.to_i
		json.message_updated_at message.updated_at.to_i
	end
end

if @chat
	json.chat @chat, :id, :quick_msg, :sender_id, :file_type
	json.file @chat.file.url
	json.chat_created_at @chat.created_at.to_i
	json.chat_updated_at @chat.updated_at.to_i
end
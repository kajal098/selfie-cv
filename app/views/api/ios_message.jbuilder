if @messages
	json.messages @messages do |message|
		json.extract! message, :id, :text, :role
		json.message_created_at message.created_at.to_i
		json.message_updated_at message.updated_at.to_i
	end
end
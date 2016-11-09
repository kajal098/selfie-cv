if @messages
	json.messages @messages do |message|
		json.extract! message, :id, :text, :role
		json.message_created_at message.created_at.to_i
		json.message_updated_at message.updated_at.to_i
	end
end

if @chat
	json.msg @chat, :id, :group_id, :quick_msg, :activity, :file_type
	json.sender_id @chat.user ? @chat.sender_id : ""
   	json.sender_first_name @chat.user ? @chat.user.first_name : ""
   	json.sender_last_name @chat.user ? @chat.user.last_name : ""
	json.file @chat.file.url
	json.msg_created_at @chat.created_at.to_i
	json.msg_updated_at @chat.updated_at.to_i
end

if @chats
	@chats = @chats.order('created_at ASC')
	json.msgs @chats do |chat|
		if chat.chat_schedule_id.nil?
			json.msg chat, :id, :group_id, :quick_msg, :activity, :file_type
			json.sender_id chat.user ? chat.sender_id : ""
		   	json.sender_first_name chat.user ? chat.user.first_name : ""
		   	json.sender_last_name chat.user ? chat.user.last_name : ""
			json.file chat.file.url
			json.msg_created_at chat.created_at.to_i
			json.msg_updated_at chat.updated_at.to_i			
		else
			json.msg chat.chat_schedule, :id, :name, :info
			json.date chat.chat_schedule.date.count.times do |i|
				json.set!("date", chat.chat_schedule.date[i].to_s)
			end
			json.my_time chat.chat_schedule.my_time.count.times do |i|
				json.set!("time", chat.chat_schedule.my_time[i].to_s)
			end
			json.description chat.chat_schedule.description.count.times do |i|
				json.set!("description", chat.chat_schedule.description[i].to_s)
			end
			json.group_id chat.chat_schedule.group_id.count.times do |i|
				json.set!("group", chat.chat_schedule.group_id[i].to_s)
			end
		end
	end
end

if @chat_schedule
	json.chat_schedule @chat_schedule, :id, :name, :info
	json.date @chat_schedule.date.count.times do |i|
		json.set!("date", @chat_schedule.date[i].to_s)
	end
	json.my_time @chat_schedule.my_time.count.times do |i|
		json.set!("time", @chat_schedule.my_time[i].to_s)
	end
	json.description @chat_schedule.description.count.times do |i|
		json.set!("description", @chat_schedule.description[i].to_s)
	end
	json.group_id @chat_schedule.group_id.count.times do |i|
		json.set!("group", @chat_schedule.group_id[i].to_s)
	end
end
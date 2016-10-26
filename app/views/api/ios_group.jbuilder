if @group
	
		json.Group @group, :id, :name, :code, :deleted_from
		json.group_pic @group.thumb_url
		json.group_created_at @group.created_at.to_i
		json.group_updated_at @group.chats.last.created_at.to_i

		json.group_users @group.accepted_users do |group_user|
			json.extract! group_user, :id, :group_id, :user_id, :admin, :status	, :deleted_at
			
			json.user_name group_user.user ? group_user.user.first_name : ""

			json.profile_pic group_user.user.file.url
			json.group_user_created_at group_user.created_at.to_i
			json.group_user_updated_at group_user.updated_at.to_i
		end

		json.group_chat @group.chats do |chat|
				json.extract! chat, :id, :quick_msg, :activity, :sender_id, :file_type	
				
				json.file chat.file.url
				json.chat_created_at chat.created_at.to_i
				json.chat_updated_at chat.updated_at.to_i
		end


		json.unread_message Chat::count_unread(@group,current_user)
  
		json.last_message do
		 
		    if(Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).count > 0)

		      json.extract! Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last, :id, :sender_id, :group_id, :quick_msg, :activity, :user_ids, :file_type

		      json.file Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last.file.url

		      json.create_at Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last.created_at.to_i
		      
		      json.update_at Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last.updated_at.to_i
		  else
		    json.array!
		  end
		end
	
end



if @groups
	json.groups @groups do |group|
		json.extract! group, :id, :name, :code, :deleted_from
		json.group_pic group.thumb_url
		json.group_created_at group.created_at.to_i
		json.group_updated_at group.chats.last.created_at.to_i
	

		json.group_users group.accepted_users do |group_user|
				json.extract! group_user, :id, :group_id, :user_id, :admin, :status	, :deleted_at
				
				json.user_name group_user.user ? group_user.user.first_name : ""

				json.profile_pic group_user.user.file.url
				json.group_user_created_at group_user.created_at.to_i
				json.group_user_updated_at group_user.updated_at.to_i
		end

		json.group_chat group.chats do |chat|
				json.extract! chat, :id, :quick_msg, :activity, :sender_id, :file_type	
				
				json.file chat.file.url
				json.chat_created_at chat.created_at.to_i
				json.chat_updated_at chat.updated_at.to_i
		end

		json.unread_message Chat::count_unread(group,current_user)
  
		json.last_message do
		 
		    if(Chat::where(group_id: group.id).where("created_at >= ?", group.users.current(current_user).updated_at).count > 0)

		      json.extract! Chat::where(group_id: group.id).where("created_at >= ?", group.users.current(current_user).updated_at).last, :id, :sender_id, :group_id, :quick_msg, :activity, :user_ids, :file_type

		      json.file Chat::where(group_id: group.id).where("created_at >= ?", group.users.current(current_user).updated_at).last.file.url

		      json.create_at Chat::where(group_id: group.id).where("created_at >= ?", group.users.current(current_user).updated_at).last.created_at.to_i
		      
		      json.update_at Chat::where(group_id: group.id).where("created_at >= ?", group.users.current(current_user).updated_at).last.updated_at.to_i
		  else
		    json.array!
		  end
		end



	end
end

json.status "Success"

if @group
	
		json.Group @group, :id, :name, :code
		json.group_pic @group.thumb_url
		json.group_created_at @group.created_at.to_i
		json.group_updated_at @group.updated_at.to_i

		json.group_users @group.users do |group_user|
			json.extract! group_user, :id, :group_id, :user_id, :admin, :status	
			json.user_name group_user.user.first_name
			json.profile_pic group_user.user.file.url
			json.group_user_created_at group_user.created_at.to_i
			json.group_user_updated_at group_user.updated_at.to_i
		end
	
end

if @group_user

	json.GroupUser @group_user, :id, :group_id, :user_id, :admin, :status
	json.user_name @roup_user.user.first_name
	json.profile_pic @group_user.user.file.url
	json.group_user_created_at @group_user.created_at.to_i
	json.group_user_updated_at @group_user.updated_at.to_i
	
end

if @groups
	json.groups @groups do |group|
		json.extract! group, :id, :name, :code
		json.group_pic group.thumb_url
		json.group_created_at group.created_at.to_i
		json.group_updated_at group.updated_at.to_i
	end
end

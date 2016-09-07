json.status "Success"

if @group
	
		json.Group @group, :id, :name, :code
		
		json.created_at @group.created_at.to_i
		json.updated_at @group.updated_at.to_i
	
end

if @group_user

	json.GroupUser @group_user, :id, :group_id, :user_id, :status, :invite, :admin
	
	json.created_at @group_user.created_at.to_i
		json.updated_at @group_user.updated_at.to_i
	
end
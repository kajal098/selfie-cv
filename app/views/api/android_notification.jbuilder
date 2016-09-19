json.status "Success"

if @user_like
	json.User @user_like, :id, :user_id, :like_id
	json.LikedUser 

	json.LikedUser do
		 
		    if(Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).count > 0)

		      json.extract! User::where(id: @user_like.like_id)..last, :id, :sender_id, :group_id, :quick_msg, :user_ids, :file_type

		      json.file Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last.file.url

		      json.create_at Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last.created_at.to_i
		      
		      json.update_at Chat::where(group_id: @group.id).where("created_at >= ?", @group.users.current(current_user).updated_at).last.updated_at.to_i
		  else
		    json.array!
		  end
		end


end
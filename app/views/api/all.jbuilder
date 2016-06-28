if @user

			json.User @user, :id, :username, :email, :role
			json.created_at @user.created_at.to_i
			json.updated_at @user.updated_at.to_i
			
end
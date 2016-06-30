if @user

			json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :address, :city, :school_name, :education_in
			json.created_at @user.created_at.to_i
			json.updated_at @user.updated_at.to_i
			
end
if @user.role == 'Jobseeker'
	json.User @user, :id
elsif @user.role == 'Company'
	json.User @user, :id, :company_name	
end

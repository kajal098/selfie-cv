
	if @user.role == 'Jobseeker'
		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :education_in, :school_name, :year

		json.profile @user.profile_thumb_url

		json.resume @user.resume_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
	else if @user.role == 'Company'
		json.User @user, :id, :company_name, :company_establish_from, :company_industry, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :companu_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.logo @user.logo_thumb_url

		json.profile @user.company_profile_thumb_url

		json.brochure @user.brochure_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
	end
	end

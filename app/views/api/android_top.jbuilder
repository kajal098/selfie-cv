json.status "Success"

if @top_users
	json.top_users @top_users do |user|
		if user.role == "Jobseeker"
			json.extract! user, :id, :username, :first_name, :last_name, :city, :country
			json.total_per user.user_meter.total_per
			json.profile_thumb user.profile_thumb_url
			json.profile user.profile_pic.url
		elsif user.role == "Company"
			json.extract! user, :id, :username, :company_name, :company_establish_from, :company_city, :company_country
			json.total_per user.user_meter.total_per
			json.logo_thumb user.logo_thumb_url
			json.logo user.company_logo.url
		end
	end
end
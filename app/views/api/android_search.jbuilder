json.status "Success"

if @searched_users
		json.searched_users @searched_users do |user|
				if user.role == "Jobseeker"
						json.extract! user, :id, :username, :first_name, :last_name, :total_per, :city, :country
						json.profile_thumb user.profile_thumb_url
						json.profile user.profile_pic.url


				elsif user.role == "Company"
						json.extract! user, :id, :username, :company_name, :total_per, :company_establish_from, :company_city, :company_country

						json.logo_thumb user.logo_thumb_url
						json.logo user.company_logo.url

				end
		end
end
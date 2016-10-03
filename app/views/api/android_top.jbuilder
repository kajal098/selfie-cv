json.status "Success"

if @top_users
		json.top_users @top_users do |user|
				if user.role == "Jobseeker"
						json.extract! user, :id, :username, :first_name, :total_per, :city, :country

				elsif user.role == "Company"
						json.extract! user, :id, :username, :company_name, :total_per, :company_establish_from, :company_city, :company_country

				end
		end
end
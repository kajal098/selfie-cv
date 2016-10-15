json.status "Success"

if @searched_company
		json.searched_company @searched_company do |user|
				
						json.extract! user, :id, :username, :company_name, :total_per, :company_establish_from, :company_city, :company_country

						json.logo_thumb user.logo_thumb_url
						json.logo user.company_logo.url

				
		end
end
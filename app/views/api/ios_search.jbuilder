json.status "Success"
if @searched_company
	json.searched_company @searched_company do |user|
		json.extract! user, :id, :username, :company_name, :user_total_per, :company_establish_from, :company_city, :country_id

		json.country_name user.stock_country ? user.stock_country.name : ""

		json.date_format user.company_stock ? user.company_stock.date_format : "dd/mm/yyyy"

		json.logo_thumb user.logo_thumb_url
		json.logo user.company_logo.url
	end
end
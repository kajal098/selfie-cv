if @galleries
	current_user.company_galeries.each do |galery|
		json.User galery, :id
		json.File galery.file.url
	end
end
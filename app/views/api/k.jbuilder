if @galeries
	@galeries.each do |galery|
		json.User galery, :id
		json.File galery.file.url
	end
end
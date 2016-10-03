if @galleries
	@galleries.each do |galery|
		json.User galery, :id
		json.File galery.file.url
	end
end
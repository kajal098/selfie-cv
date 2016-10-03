if @galeries
	json.galeries @galeries.each do |galery|
		json.User galery, :id
		json.FileThumb galery.thumb_url
		json.File galery.file.url
	end
end
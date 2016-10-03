if @galeries
@all_galeries = @galeries.order('created_at DESC')
	json.galeries @all_galeries do |galery|
		json.extract! galery, :id

		json.FileThumb galery.thumb_url
		json.File galery.file.url

		json.galery_created_at galery.created_at.to_i
		json.galery_updated_at galery.updated_at.to_i
	end
end
json.galeries @user.user_galeries do |galery|
		json.extract! galery, :id, :user_id

		json.file galery.thumb_url

		json.created_at galery.created_at.to_i
		json.updated_at galery.updated_at.to_i
	end

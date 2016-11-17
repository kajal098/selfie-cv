if @folder
	json.folder @folder, :id, :name
end

if @user_folders
	json.user_folders @user_folders do |user_folder|
		json.extract! user_folder, :id, :user_id, :folder_id
		json.user user_folder.user.username
		json.folder_name user_folder.folder.name
		json.user_favs UserFavourite.where(folder_id: user_folder.folder_id) do |user_fav|
			json.id user_fav.fav_user.id
			json.username user_fav.fav_user.username
		end
	end
end

if @user_folder
	json.user_folder @user_folder, :id, :user_id, :folder_id
	json.user @user_folder.user.username
	json.folder @user_folder.folder.name
	json.user_favs UserFavourite.where(folder_id: @user_folder.folder_id) do |user_fav|
		json.id user_fav.fav_user.id
		json.username user_fav.fav_user.username
	end
end
json.status "Success"

if @folder
	json.folder @folder, :id, :name
end

if @user_folders
	json.user_folders @user_folders do |user_folder|
		json.extract! user_folder, :id, :folder_id
		json.folder_name user_folder.folder.name
		json.favs UserFavourite.where(folder_id: user_folder.folder_id) do |user|
			json.id user.user.id
		end
	end
end

if @user_folder
	json.user_folder @user_folder, :id, :user_id, :folder_id
	json.user @user_folder.user.username
	json.folder @user_folder.folder.name
end
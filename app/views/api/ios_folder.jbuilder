if @folder
	json.Folder @folder, :id, :name
end

if @user_folder
	json.UserFolder @user_folder, :id, :user_id, :folder_id
	json.user @user_folder.user.username
	json.folder @user_folder.folder.name
end
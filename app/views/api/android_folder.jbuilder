json.status "Success"

if @folder
	json.folder @folder, :id, :name
end

if @user_folders
	json.user_folders @user_folders do |user_folder|
		json.folder_id user_folder.folder.id
		json.folder_name user_folder.folder.name
		json.folder_default user_folder.folder.default_status
		json.user_favs UserFavourite.where(user_id: current_user.id).where(folder_id: user_folder.folder_id).all do |user_fav|
			json.id user_fav.fav_user.id
			json.username user_fav.fav_user.username
		end
	end
end

if @user_folder
	json.user_folder @user_folder, :id, :user_id, :folder_id
	json.user @user_folder.user.username
	json.folder @user_folder.folder.name
	json.folder_default @user_folder.folder.default_status
	json.user_favs UserFavourite.where(user_id: current_user.id).where(folder_id: @user_folder.folder_id).all do |user_fav|
		json.id user_fav.fav_user.id
		json.username user_fav.fav_user.username
	end
end

if @my_folder_fav
	json.user_favs @my_folder_fav do |user_fav|
			json.extract! user_fav.fav_user, :id, :username, :company_name, :company_establish_from, :company_city, :country_id

			json.country_name user_fav.fav_user.company_stock ? user_fav.fav_user.company_stock.sensex_co : ""

			json.total_per user_fav.fav_user.user_meter.total_per
			json.logo_thumb user_fav.fav_user.logo_thumb_url
			json.logo user_fav.fav_user.company_logo.url
	end
end
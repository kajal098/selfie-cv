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

if @my_folder
	json.user_favs UserFavourite.where(user_id: current_user.id).where(folder_id: @my_folder.folder_id).all do |user_fav|
		if current_user.role == "Jobseeker"
			json.extract! user_fav.fav_user, :id, :username, :first_name, :last_name, :city, :country_id

			json.country_name user_fav.fav_user.company_stock ? user_fav.fav_user.company_stock.sensex_co : ""

			json.skills !user_fav.fav_user.user_educations.empty? ? user_fav.fav_user.user_educations.map(&:skill).join(",") : ""
			json.total_per user_fav.fav_user.user_meter.total_per
			json.profile_thumb user_fav.fav_user.profile_thumb_url
			json.profile user_fav.fav_user.profile_pic.url
		elsif current_user.role == "Company"
			json.extract! user, :id, :username, :company_name, :company_establish_from, :company_city, :country_id

			json.country_name user_fav.fav_user.company_stock ? user_fav.fav_user.company_stock.sensex_co : ""

			json.total_per user_fav.fav_user.user_meter.total_per
			json.logo_thumb user_fav.fav_user.logo_thumb_url
			json.logo user_fav.fav_user.company_logo.url
		end
	end
end
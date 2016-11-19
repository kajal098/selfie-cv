class Folder < ActiveRecord::Base
	has_many    :user_favourites, class_name: 'UserFavourite',foreign_key: "favourite_id"
	has_many    :user_folders, class_name: 'UserFolder',foreign_key: "folder_id"
end

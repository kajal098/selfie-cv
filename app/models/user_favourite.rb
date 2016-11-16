class UserFavourite < ActiveRecord::Base
	belongs_to :user
	belongs_to :user_folder, class_name: 'UserFolder',foreign_key: "folder_id"
end

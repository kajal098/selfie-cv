class UserFavourite < ActiveRecord::Base
	belongs_to :user
	belongs_to :fav_user, class_name: 'User',foreign_key: "favourite_id"
	belongs_to :folder
end

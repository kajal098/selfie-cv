class UserFolder < ActiveRecord::Base
	belongs_to :user
	belongs_to :folder
	has_many   :user_favourites, class_name: 'UserFavourite',foreign_key: "favourite_id"
end

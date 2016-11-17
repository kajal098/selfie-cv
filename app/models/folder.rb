class Folder < ActiveRecord::Base
	has_many    :user_favourites, class_name: 'UserFavourite',foreign_key: "favourite_id"
end

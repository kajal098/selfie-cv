class UserFavourite < ActiveRecord::Base
	belongs_to :user
	belongs_to :folder
end

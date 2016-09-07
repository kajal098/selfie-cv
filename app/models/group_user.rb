class GroupUser < ActiveRecord::Base
	has_many :user
	has_many :groups
end

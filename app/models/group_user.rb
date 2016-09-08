class GroupUser < ActiveRecord::Base
	belongs_to :group
	belongs_to :user, foreign_key: "user_id"
end

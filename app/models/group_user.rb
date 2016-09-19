class GroupUser < ActiveRecord::Base
	enum status: { no_member:0, joined: 1, leaved: 10, deleted: 100 }
	belongs_to :group
	belongs_to :user, foreign_key: "user_id"

	paginates_per 10
	
	scope :current, -> (user) {where(user_id: user.id).first}

end

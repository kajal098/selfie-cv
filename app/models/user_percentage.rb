class UserPercentage < ActiveRecord::Base


	scope :fetch, -> (type) {where(ptype: type).order(:id) }

	belongs_to :user_percentage, foreign_key: "parent_id"

end

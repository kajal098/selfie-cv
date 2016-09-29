class UserPercentage < ActiveRecord::Base


	scope :fetch, -> (type) {where(ptype: type) }


end

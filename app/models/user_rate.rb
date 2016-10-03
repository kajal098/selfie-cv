class UserRate < ActiveRecord::Base
	belongs_to :user
	extend Enumerize
	enum rate_type: { bronze: 0, silver: 1, gold: 2 }
end

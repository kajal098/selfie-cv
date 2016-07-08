class UserAward < ActiveRecord::Base
	belongs_to :user
	validates :name,:award_type,:description, presence: true
	
end

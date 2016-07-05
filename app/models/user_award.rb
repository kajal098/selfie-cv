class UserAward < ActiveRecord::Base
	belongs_to :user
	validates :name,:type,:description, presence: true
	
end

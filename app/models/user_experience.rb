class UserExperience < ActiveRecord::Base
	validates :name,:start_from,:working_till,:designation, presence: true
	
end

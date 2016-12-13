class Course < ActiveRecord::Base

	paginates_per 10
	
	validates :name, presence: { message: "Course name must be filled" }
	
end

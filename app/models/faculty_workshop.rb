class FacultyWorkshop < ActiveRecord::Base

	belongs_to :user

	validates :description, presence: true

	after_save :percent_of_workshop

    def percent_of_workshop()
    	user = self.user
        
        if user.faculty_workshops.count > 0  
        	workshop_per = 0
        	user.faculty_workshops.each do |workshop|   
        	   		if 
	                    workshop.file_type = "doc"
	                    workshop_per = 100
	                    break
	                else
	                    workshop_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('faculty_workshop_per' ,workshop_per)
        return true
    end

end

class FacultyWorkshop < ActiveRecord::Base

	belongs_to :user

	validates :description, presence: true

	after_save :percent_of_workshop
    after_destroy :percent_of_workshop

    def percent_of_workshop()
    	user = self.user
        
        if user.faculty_workshops.count > 0  
        	workshop_per = 0
            setting_per = UserPercentage.find_by_key('project').value.to_i
        	user.faculty_workshops.each do |workshop| 

                    if workshop.description.present?           	   		
	                    workshop_per = setting_per * 1
	                    break
	                else
	                    workshop_per = setting_per * 0.5
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('faculty_workshop_per' ,workshop_per)
        user.profile_meter_total
        return true
    end

end

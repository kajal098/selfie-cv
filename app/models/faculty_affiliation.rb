class FacultyAffiliation < ActiveRecord::Base

	belongs_to :user

	validates :collage_name,:subject,:designation,:join_from, presence: true
	
	after_save :percent_of_affiliation

    def percent_of_affiliation()
    	user = self.user
        
        if user.faculty_affiliations.count > 0  
        	affiliation_per = 0
        	user.faculty_affiliations.each do |affiliation|   
        	   		
	                    affiliation_per = 100
	               
        	end
        end 
        user.user_meter.update_column('faculty_affiliation_per' ,affiliation_per)
        return true
    end

end

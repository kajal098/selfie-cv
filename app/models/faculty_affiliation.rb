class FacultyAffiliation < ActiveRecord::Base

	belongs_to :user

	validates :collage_name,:subject,:designation,:join_from, presence: true
    #validates_format_of :join_from, :with => /\d{2}\/\d{2}\/\d{4}/
    #validates_format_of :join_till, :with => /\d{2}\/\d{2}\/\d{4}/
	
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
        user.profile_meter_total
        return true
    end

end

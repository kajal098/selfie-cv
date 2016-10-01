class FacultyResearch < ActiveRecord::Base

	belongs_to :user

	validates :title,:description, presence: true
	
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_research

    def percent_of_research()
    	user = self.user
        
        if user.faculty_researches.count > 0  
        	research_per = 0
        	user.faculty_researches.each do |research|   
        	   		if research.file_type == "doc"
	                    research_per = 100
	                    break
	                else
	                    research_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('faculty_research_per' ,research_per)
        return true
    end

end

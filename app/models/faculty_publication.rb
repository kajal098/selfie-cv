class FacultyPublication < ActiveRecord::Base

	belongs_to :user

	validates :title,:description, presence: true
	
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_publication
    after_destroy :percent_of_publication

    def percent_of_publication()
    	user = self.user
        
        if user.faculty_publications.count > 0  
        	publication_per = 0
        	user.faculty_publications.each do |publication|   
        	   		if publication.file_type == "doc"
	                    publication_per = 100
	                    break
	                else
	                    publication_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('faculty_publication_per' ,publication_per)
        user.profile_meter_total
        return true
    end

end

class UserCurricular < ActiveRecord::Base
	belongs_to :user

	validates :curricular_type,:team_type,:location,:date, presence: true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/

	after_save :percent_of_curri

	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end

    def photo_url; file.url; end

    def percent_of_curri()
    	user = self.user
        curri_per = 0
        if user.user_curriculars.count > 0  
        	user.user_curriculars.each do |curri|   
        	   		if curri.file_type == "image"
	                    curri_per = 100
	                    break
	                elsif curri.file_type == "video"
	                    curri_per = 100
	                    break
	                else
	                    curri_per = 30
	                end
        		       	
        	end
        end 
        return curri_per  
        user.user_meter.update_column('curri_per' ,curri_per)
    end





end

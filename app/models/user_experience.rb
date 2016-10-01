class UserExperience < ActiveRecord::Base
	#validates_format_of :start_from, :with => /\d{2}\/\d{2}\/\d{4}/
	#validates_format_of :working_till, :with => /\d{2}\/\d{2}\/\d{4}/
	mount_uploader :file, FileUploader
    def thumb_url
           
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_exp

    def percent_of_exp()
    	user = self.user
        
        if user.user_experiences.count > 0  
        	exp_per = 0
        	user.user_experiences.each do |exp|   
        	   		if exp.file_type == "doc"
	                    exp_per = 100
	                    break
	                else
	                    exp_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('working_exp_per' ,exp_per)
        return true
    end

end

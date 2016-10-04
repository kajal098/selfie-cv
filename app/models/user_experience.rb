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
            setting_per = UserPercentage.find_by_key('experience').value
        	user.user_experiences.each do |exp|   
        	   		if exp.file_type == "doc"
	                    exp_per = setting_per.to_i.value * 1
	                    break
	                else
	                    exp_per = setting_per.to_i.value * 0.5
	                end
        		       	
        	end
        user.user_meter.update_column('working_exp_per' ,exp_per)
        end 
        return true
    end

end

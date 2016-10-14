class UserExperience < ActiveRecord::Base
	belongs_to :user
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
        	   		if exp.exp_type == "experience"
	                    exp_per = setting_per.to_i.value * 1
	                    break
	                elsif exp.exp_type == "fresher"
	                    exp_per = setting_per.to_i.value * 0.4
	                end        		       	
        	end
        user.user_meter.update_column('experience_per' ,exp_per)
        end 
        return true
    end


    def total_experience
        if self.current_company
            $month = ((Date.today.to_time - self.start_from.to_time)/1.month.second).round(0)
        else
            $month = ((self.working_till.to_time - self.start_from.to_time)/1.month.second).round(0)
        end
        return $month
    end

end

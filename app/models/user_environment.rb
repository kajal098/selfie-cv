class UserEnvironment < ActiveRecord::Base
    belongs_to :user
	validates :env_type,:title, presence: true
	mount_uploader :file, FileUploader	
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_env

    def percent_of_env()
    	user = self.user
        
        if user.user_environments.count > 0  
        	env_per = 0
            setting_per = UserPercentage.find_by_key('workingenv').value
        	user.user_environments.each do |env|   
        	   		if env.file_type == "audio"
	                    env_per = setting_per.to_i * 0.7
	                    break
	                elsif env.file_type == "video"
	                    env_per = setting_per.to_i * 1
	                    break
	                else
	                    env_per = setting_per.to_i * 0.5
	                end
        		       	
        	end
             user.user_meter.update_column('working_env_per' ,env_per)
        end 
       
        return true
    end

end

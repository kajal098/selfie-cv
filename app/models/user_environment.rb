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
        	user.user_environments.each do |env|   
        	   		if 
	                    env.file_type = "audio"
	                    env_per = 70
	                    break
	                elsif 
	                    env.file_type = "video"
	                    env_per = 100
	                    break
	                else
	                    env_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('working_env_per' ,env_per)
        return true
    end

end

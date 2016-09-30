class UserFutureGoal < ActiveRecord::Base
	belongs_to :user
	validates :goal_type,:title,:term_type, presence: true
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_goal

    def percent_of_goal()
    	user = self.user
        
        if user.user_future_goals.count > 0  
        	goal_per = 0
        	user.user_future_goals.each do |goal|   
        	   		if 
	                    goal.file_type = "audio"
	                    goal_per = 70
	                    break
	                elsif 
	                    goal.file_type = "video"
	                    goal_per = 100
	                    break
	                else
	                    goal_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('future_goal_per' ,goal_per)
        return true
    end

end

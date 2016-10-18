class UserFutureGoal < ActiveRecord::Base
	belongs_to :user
	validates :goal_type,:title,:term_type, presence: true
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_goal
    after_destroy :percent_of_goal

    def percent_of_goal()
        user = self.user
        future_goal_per = 0
        setting_per = UserPercentage.where(key: 'futuregoal').where(ptype: user.role).first
        if user.user_future_goals.count > 0  
            user.user_future_goals.each do |future_goal|   
                    if future_goal.file_type == "video"
                        future_goal_per = setting_per.value.to_i * 1
                        break
                    elsif future_goal.file_type == "audio"
                        future_goal_per = setting_per.value.to_i * 0.7
                        break
                    else
                        future_goal_per = setting_per.value.to_i * 0.5
                    end
                        
            end
        end 
        user.user_meter.update_column('future_goal_per' ,future_goal_per)
        return true
    end


    



end

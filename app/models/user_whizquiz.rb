class UserWhizquiz < ActiveRecord::Base
	belongs_to :user
	belongs_to :whizquiz
	mount_uploader :review, FileUploader
    def thumb_url
          
            review.url(:thumb)
        
    end
    def photo_url; review.url; end

    after_save :percent_of_whizquiz
    before_destroy :percent_of_whizquiz

    def percent_of_whizquiz()
    	@count = user.user_whizquizzes.count
        whizquiz_per = 0
        setting_per = UserPercentage.find_by_key('whizquiz').value.to_i
        if @count > 0  
        	if @count >= 1 && @count <= 2
	            @whizquiz_per = setting_per * 0.3
	        elsif @count >= 3 &&  @count <= 5
	            @whizquiz_per = setting_per * 0.5
	        elsif @count >= 9
	            @whizquiz_per = setting_per * 1
	        end
        end 
		user.user_meter.update_column('whizquiz_per' ,whizquiz_per)
        user.profile_meter_total
        return true
    end


end

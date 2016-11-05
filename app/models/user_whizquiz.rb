class UserWhizquiz < ActiveRecord::Base
	belongs_to :user
	belongs_to :whizquiz
	mount_uploader :review, FileUploader
    def thumb_url
          
            review.url(:thumb)
        
    end
    def photo_url; review.url; end

    after_save :percent_of_whizquiz
    #before_destroy :reduce_percentage

    def percent_of_whizquiz()
    	@count = user.user_whizquizzes.where(status: true).count
        whizquiz_per = 0
        setting_per = UserPercentage.find_by_key('whizquiz').value.to_i
        if @count > 0  
        	if @count >= 1 && @count <= 2
	            whizquiz_per = setting_per * 0.3
	        elsif @count >= 3 &&  @count <= 5
	            whizquiz_per = setting_per * 0.5
	        elsif @count >= 9
	            whizquiz_per = setting_per * 1
	        end
        end 
		user.user_meter.update_column('whizquiz_per' ,whizquiz_per)
        user.profile_meter_total
        return true
    end

    # def percent_of_whizquiz()
    # 	user = self.user
    #     whizquiz_per = 0
    #     setting_per = UserPercentage.find_by_key('whizquiz').value.to_i
    #     if user.user_whizquizzes.count > 0  
    #     	user.user_whizquizzes.each do |whizquiz|   
    #     	   		  if whizquiz.file_type == "video"
	   #                  whizquiz_per = setting_per.value.to_i * 1
	   #                  break
	   #              elsif whizquiz.file_type == "image"
	   #                  whizquiz_per = setting_per.value.to_i * 0.7
	   #                  break
	   #              else
	   #                  whizquiz_per = setting_per.value.to_i * 0.5
	   #              end        		       	
    #     	end
    #     end 
    #     user.user_meter.update_column('whizquiz_per' ,whizquiz_per)
    #     user.profile_meter_total
    #     return true
    # end


    # def reduce_percentage
    #     user = self.user
    #     whizquiz_per = 0
    #     if user.user_whizquizzes.where.not(id: self.id).count > 0 
    #         setting_per = UserPercentage.find_by_key('whizquiz').value.to_i
    #         user.user_whizquizzes.where.not(id: self.id).each do |whizquiz|   
    #                 if whizquiz.file_type == "video"
    #                     whizquiz_per = setting_per.value.to_i * 1
    #                     break
    #                 elsif whizquiz.file_type == "image"
    #                     whizquiz_per = setting_per.value.to_i * 0.7
    #                     break
    #                 else
    #                     whizquiz_per = setting_per.value.to_i * 0.5
    #                 end
    #         end
    #     end
    #     user.user_meter.update_column('whizquiz_per' ,whizquiz_per)
    #     user.profile_meter_total
    #     return true
    # end


end

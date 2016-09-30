class UserAward < ActiveRecord::Base
	belongs_to :user
	validates :name,:award_type,:description, presence: true

	after_save :percent_of_award
	
	mount_uploader :file, FileUploader
    def thumb_url
         
            file.url(:thumb)
    end

    def photo_url; file.url; end

    def percent_of_award()
    	user = self.user
        award_per = 0
        if user.user_awards.count > 0  
        	user.user_awards.each do |award|   
        	   		if 
	                    award.file_type = "image"
	                    award_per = 100
	                    break
	                else
	                    award_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('award_per' ,award_per)
        return true
    end


end

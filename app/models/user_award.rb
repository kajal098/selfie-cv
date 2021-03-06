class UserAward < ActiveRecord::Base
	belongs_to :user
	validates :name,:award_type,:description, presence: true

	mount_uploader :file, FileUploader
    def thumb_url
         
            file.url(:thumb)
    end

    def photo_url; file.url; end

    after_save :percent_of_award
    before_destroy :reduce_percentage

    def percent_of_award()
    	user = self.user
        award_per = 0
        setting_per = UserPercentage.where(key: 'award').where(ptype: user.role).first
        if user.user_awards.count > 0  
        	user.user_awards.each do |award|   
        	   		if award.file_type == "video"
	                    award_per = setting_per.value.to_i * 1
	                    break
                    elsif award.file_type == "image"
                        award_per = setting_per.value.to_i * 0.7
                        break
	                else
	                    award_per = setting_per.value.to_i * 0.5
	                end        		       	
        	end
        end 
        user.user_meter.update_column('award_per' ,award_per)
        user.profile_meter_total
        return true
    end


    def reduce_percentage
        user = self.user
        award_per = 0
        if user.user_awards.where.not(id: self.id).count > 0 
            setting_per = UserPercentage.where(key: 'award').where(ptype: user.role).first
            user.user_awards.where.not(id: self.id).each do |award|   
                    if award.file_type == "video"
                        award_per = setting_per.value.to_i * 1
                        break
                    elsif award.file_type == "image"
                        award_per = setting_per.value.to_i * 0.7
                        break
                    else
                        award_per = setting_per.value.to_i * 0.5
                    end
            end
        end
        user.user_meter.update_column('award_per' ,award_per)
        user.profile_meter_total
        return true
    end

end

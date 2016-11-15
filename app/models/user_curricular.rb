class UserCurricular < ActiveRecord::Base
	belongs_to :user

	validates :curricular_type,:team_type,:location,:date, :hobby, presence: true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/

	mount_uploader :file, FileUploader
    def thumb_url          
            file.url(:thumb)        
    end
    def photo_url; file.url; end

    after_save :percent_of_curri
    before_destroy :reduce_percentage

    def percent_of_curri()
    	user = self.user
        curri_per = 0
        setting_per = UserPercentage.where(key: 'extra').where(ptype: user.role).first
        if user.user_curriculars.count > 0  
        	user.user_curriculars.each do |curri|   
        	   		if curri.file_type == "video"
	                    curri_per = setting_per.value.to_i * 1
	                    break
	                elsif curri.file_type == "image"
	                    curri_per = setting_per.value.to_i * 0.7
	                else
	                    curri_per = setting_per.value.to_i * 0.3
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('curri_per' ,curri_per)
        user.profile_meter_total
        return true      
    end

    def reduce_percentage
        user = self.user
        curri_per = 0
        if user.user_curriculars.where.not(id: self.id).count > 0 
            setting_per = UserPercentage.where(key: 'extra').where(ptype: user.role).first
            user.user_curriculars.where.not(id: self.id).each do |curri|   
                    if curri.file_type == "video"
                        curri_per = setting_per.value.to_i * 1
                        break
                    elsif curri.file_type == "image"
                        curri_per = setting_per.value.to_i * 0.7
                    else
                        curri_per = setting_per.value.to_i * 0.3
                    end
                        
            end
        end
        user.user_meter.update_column('curri_per' ,curri_per)
        user.profile_meter_total
        return true
    end




end

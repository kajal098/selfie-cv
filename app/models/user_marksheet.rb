class UserMarksheet < ActiveRecord::Base
    belongs_to :user

	paginates_per 5	

	validates :school_name, :standard, :grade, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true

	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_marksheet
    before_destroy :reduce_percentage

    def percent_of_marksheet()
    	user = self.user
        
        if user.user_marksheets.count > 0  
        	student_marksheet_per = 0
        	setting_per = UserPercentage.find_by_key('marksheet').value.to_i
        	user.user_marksheets.each do |marksheet|   

        	   		if marksheet.file_type == "image"
	                    student_marksheet_per = setting_per * 1
	                    break
                    elsif marksheet.file_type == "doc"
                        student_marksheet_per = setting_per * 1
                        break
	                else
	                    student_marksheet_per = setting_per * 0.5
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('student_marksheet_per' ,student_marksheet_per)
        user.profile_meter_total
        return true
    end

    def reduce_percentage
        user = self.user
        student_marksheet_per = 0
        if user.user_marksheets.where.not(id: self.id).count > 0 
            setting_per = UserPercentage.find_by_key('marksheet').value.to_i
            user.user_marksheets.where.not(id: self.id).each do |marksheet|   
                    if marksheet.file_type == "image"
                        student_marksheet_per = setting_per * 1
                        break
                    elsif marksheet.file_type == "doc"
                        student_marksheet_per = setting_per * 0.7
                        break
                    else
                        student_marksheet_per = setting_per * 0.5
                    end
            end
        end
        user.user_meter.update_column('student_marksheet_per' ,student_marksheet_per)
        user.profile_meter_total
        return true
    end
    
end
class UserProject < ActiveRecord::Base
    belongs_to :user

	paginates_per 10	

	validates :title, :description, presence: true

    mount_uploader :file, FileUploader
    def thumb_url
         
            file.url(:thumb)
    end

    def photo_url; file.url; end

	after_save :percent_of_project

    def percent_of_project()
    	user = self.user
        
        if user.user_projects.count > 0  
        	student_project_per = 0
        	setting_per = UserPercentage.find_by_key('project').value.to_i
        	user.user_projects.each do |project|   

        	   		if project.title.present?           	   		
	                    workshop_per = setting_per * 1
	                    break
	                else
	                    workshop_per = setting_per * 0.5
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('student_project_per' ,student_project_per)
        user.profile_meter_total
        return true
    end

end

class UserProject < ActiveRecord::Base
    belongs_to :user

	paginates_per 5	

	validates :title, :description, presence: true

    mount_uploader :file, FileUploader
    def thumb_url
         
            file.url(:thumb)
    end

    def photo_url; file.url; end

	after_save :percent_of_project

    after_save :percent_of_project
    before_destroy :reduce_percentage
    
    def percent_of_project
        user = self.user
        if user.user_projects.count > 0  
            student_project_per = 0
            setting_per = UserPercentage.find_by_key('project').value.to_i
            user.user_projects.each do |project|                      
                if project.title.present?
                    student_project_per = setting_per * 1
                end                  
            end
            user.user_meter.update_column('student_project_per' ,student_project_per)
            user.profile_meter_total
        end
        return true
    end

    def reduce_percentage
        user = self.user
        if user.user_projects.where.not(id: self.id).count == 0  
            student_project_per = 0
            user.user_meter.update_column('student_project_per' ,student_project_per)
            user.profile_meter_total
        end
        return true
    end

end

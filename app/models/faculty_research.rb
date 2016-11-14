class FacultyResearch < ActiveRecord::Base

	belongs_to :user

	validates :title,:description, presence: true
	
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_research
    before_destroy :reduce_percentage

    def percent_of_research
        user = self.user
        if user.faculty_researches.count > 0  
            faculty_research_per = 0
            setting_per = UserPercentage.find_by_key('research').value
            user.faculty_researches.each do |research|   
                if research.title.present?
                    faculty_research_per = setting_per.to_i * 1
                end                     
            end
            user.user_meter.update_column('faculty_research_per' ,faculty_research_per)
            user.profile_meter_total
        end 
        return true
    end

    def reduce_percentage
        user = self.user
        if user.faculty_researches.where.not(id: self.id).count == 0  
            faculty_research_per = 0
            user.user_meter.update_column('faculty_research_per' ,faculty_research_per)
            user.profile_meter_total
        end
        return true
    end

end

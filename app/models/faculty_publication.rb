class FacultyPublication < ActiveRecord::Base

	belongs_to :user

	validates :title,:description, presence: true
	
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_publication
    before_destroy :reduce_percentage

    def percent_of_publication
        user = self.user
        if user.faculty_publications.count > 0  
            faculty_publication_per = 0
            setting_per = UserPercentage.find_by_key('publication').value
            user.faculty_publications.each do |publication|   
                if publication.title.present?
                    faculty_publication_per = setting_per.to_i * 1
                end                     
            end
            user.user_meter.update_column('faculty_publication_per' ,faculty_publication_per)
            user.profile_meter_total
        end 
        return true
    end

    def reduce_percentage
        user = self.user
        if user.faculty_publications.where.not(id: self.id).count == 0  
            faculty_publication_per = 0
            user.user_meter.update_column('faculty_publication_per' ,faculty_publication_per)
            user.profile_meter_total
        end
        return true
    end

end

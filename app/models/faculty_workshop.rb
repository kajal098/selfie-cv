class FacultyWorkshop < ActiveRecord::Base

	belongs_to :user

	validates :description, presence: true

	after_save :percent_of_workshop
    before_destroy :reduce_percentage

    def percent_of_workshop
        user = self.user
        if user.faculty_workshops.count > 0  
            faculty_workshop_per = 0
            setting_per = UserPercentage.find_by_key('workshop').value
            user.faculty_workshops.each do |workshop|   
                if workshop.description.present?
                    faculty_workshop_per = setting_per.to_i * 1
                end                     
            end
            user.user_meter.update_column('faculty_workshop_per' ,faculty_workshop_per)
            user.profile_meter_total
        end 
        return true
    end

    def reduce_percentage
        user = self.user
        if user.faculty_workshops.where.not(id: self.id).count == 0  
            faculty_workshop_per = 0
            user.user_meter.update_column('faculty_workshop_per' ,faculty_workshop_per)
            user.profile_meter_total
        end
        return true
    end

end

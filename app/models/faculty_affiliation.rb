class FacultyAffiliation < ActiveRecord::Base

	belongs_to :user

	validates :collage_name,:subject,:designation,:join_from, presence: true
    #validates_format_of :join_from, :with => /\d{2}\/\d{2}\/\d{4}/
    #validates_format_of :join_till, :with => /\d{2}\/\d{2}\/\d{4}/
	
	after_save :percent_of_affiliation
    before_destroy :reduce_percentage

    def percent_of_affiliation
        user = self.user
        if user.faculty_affiliations.count > 0  
            faculty_affiliation_per = 0
            setting_per = UserPercentage.find_by_key('affiliation').value
            user.faculty_affiliations.each do |affiliation|   
                if affiliation.collage_name.present?
                    faculty_affiliation_per = setting_per.to_i * 1
                end                     
            end
            user.user_meter.update_column('faculty_affiliation_per' ,faculty_affiliation_per)
            user.profile_meter_total
        end 
        return true
    end

    def reduce_percentage
        user = self.user
        if user.faculty_affiliations.where.not(id: self.id).count == 0  
            faculty_affiliation_per = 0
            user.user_meter.update_column('faculty_affiliation_per' ,faculty_affiliation_per)
            user.profile_meter_total
        end
        return true
    end

end

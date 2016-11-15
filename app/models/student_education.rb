class StudentEducation < ActiveRecord::Base
	belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
	
	validates :year, :school, presence: true
	validates :year, :numericality => true, :allow_nil => true

    after_save :percent_of_student_education
    before_destroy :reduce_percentage
    
    def percent_of_student_education
        user = self.user
        if user.student_educations.count > 0  
            student_education_info_per = 0
            setting_per = UserPercentage.where(key: 'education_info').where(ptype: "Student").first
            user.student_educations.each do |edu|                      
                if edu.standard.present?
                    student_education_info_per = setting_per.value.to_i * 1
                end                  
            end
            user.user_meter.update_column('student_education_info_per' ,student_education_info_per)
            user.profile_meter_total
        end
        return true
    end

    def reduce_percentage
        user = self.user
        if user.student_educations.where.not(id: self.id).count == 0  
            student_education_info_per = 0
            user.user_meter.update_column('student_education_info_per' ,student_education_info_per)
            user.profile_meter_total
        end
        return true
    end

end

class UserEducation < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	belongs_to :specialization

	validates :course_id, :specialization_id,  :year, :school, :skill, presence: true
	validates :year, :numericality => true, :allow_nil => true

	after_save :percent_of_education
	
	def percent_of_education()
    	user = self.user
        
        if user.user_educations.count > 0  
        	education_per = 0
        	setting_per = UserPercentage.where(key: 'education').where(ptype: user.role).first
        	user.user_educations.each do |edu|          	   		
	                    if edu.skill.present?
	                    	education_per = setting_per.value.to_i * 1
	                	end                  
        	end
            user.user_meter.update_column('education_per' ,education_per)
            user.profile_meter_total
        end 
        
        return true
    end


	
end

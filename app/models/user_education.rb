class UserEducation < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	belongs_to :specialization

	after_save :percent_of_education
	
	validates :course_id, :specialization_id,  :year, :school, :skill, presence: true
	validates :year, :numericality => true, :allow_nil => true

	def percent_of_education()
    	user = self.user
        education_per = 0
        if user.user_educations.count > 0  
        	
	                    education_per = 100
	        
        end 
        return education_per  
        user.user_meter.update_column('education_per' ,education_per)
    end

	
end

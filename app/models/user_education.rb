class UserEducation < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	belongs_to :specialization

	after_save :percent_of_education
	
	validates :course_id, :specialization_id,  :year, :school, :skill, presence: true
	validates :year, :numericality => true, :allow_nil => true

	def percent_of_education()
    	user = self.user
        
        if user.user_references.count > 0  
        	education_per = 0
        	setting_per = UserPercentage.where(key: 'education').where(ptype: user.role)
        	user.user_references.each do |edu|          	   		
	                    education_per = setting_per * 1	                
        	end
            user.user_meter.update_column('education_per' ,education_per)
        end 
        
        return true
    end


	
end

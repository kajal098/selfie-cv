class StudentEducation < ActiveRecord::Base
	belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
	
	validates :year, :school, presence: true
	validates :year, :numericality => true, :allow_nil => true

	def percent_of_education()
    	user = self.user
        
        if user.user_educations.count > 0  
        	student_education_info_per = 0
        	setting_per = UserPercentage.where(key: 'education').where(ptype: "Student").first
        	user.user_educations.each do |education|   
        	   		
        	   		if education.standard.present?           	   		
	                    workshop_per = setting_per.value.to_i * 1
	                    break
	                else
	                    workshop_per = setting_per.value.to_i * 0.5
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('student_education_info_per' ,student_education_info_per)
        return true
    end

end

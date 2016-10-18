class UserPreferredWork < ActiveRecord::Base
	belongs_to :user
	validates :ind_name, :functional_name,  :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type, presence: true
	validates :current_salary, :numericality => true, :allow_nil => true
	validates :expected_salary, :numericality => true, :allow_nil => true

	after_save :percent_of_prework

	def percent_of_prework()
    	user = self.user
        if user.user_preferred_works.count > 0  
        	prework_per = 0
            setting_per = UserPercentage.find_by_key('prework').value
        	user.user_preferred_works.each do |prework|   
        	   		if prework.ind_name.present?
	                    prework_per = setting_per.to_i * 1
	                end        		       	
        	end
        user.user_meter.update_column('prework_per' ,prework_per)
        user.profile_meter_total
        end 
        return true
    end
end

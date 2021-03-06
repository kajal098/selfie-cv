class UserMarketiq < ActiveRecord::Base

	belongs_to :user
    belongs_to :marketiq

	after_save :percent_of_marketiq
    
    def percent_of_marketiq()
    	@count = user.user_marketiqs.where(status: true).count
        market_iq_per = 0
        setting_per = UserPercentage.find_by_key('marketIQ').value.to_i
        if @count > 0  
        	if @count >= 2 && @count <= 3
	            market_iq_per = setting_per * 0.3
	        elsif @count >= 3 &&  @count <= 5
	            market_iq_per = setting_per * 0.5
	        elsif @count >= 5
	            market_iq_per = setting_per * 1
	        end
        end 
		user.user_meter.update_column('market_iq_per' ,market_iq_per)
        user.profile_meter_total
        return true
    end

end

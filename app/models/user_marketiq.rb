class UserMarketiq < ActiveRecord::Base

	belongs_to :user

	after_save :percent_of_marketiq
    
    def percent_of_marketiq()
    	@count = user.user_marketiqs.where(status: true).count
        marketiq_per = 0
        setting_per = UserPercentage.find_by_key('marketIQ').value.to_i
        if @count > 0  
        	if @count >= UserPercentage.find_by_key('market_first').value.to_i && @count <= UserPercentage.find_by_key('market_second').value.to_i
	            marketiq_per = setting_per * 0.3
	        elsif @count >= UserPercentage.find_by_key('market_second').value.to_i &&  @count <= UserPercentage.find_by_key('market_third').value.to_i
	            marketiq_per = setting_per * 0.5
	        elsif @count >= UserPercentage.find_by_key('market_third').value.to_i
	            marketiq_per = setting_per * 1
	        end
        end 
		user.user_meter.update_column('marketiq_per' ,marketiq_per)
        user.profile_meter_total
        return true
    end

end

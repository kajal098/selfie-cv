class CompanyGalery < ActiveRecord::Base
	belongs_to :user
	
  mount_uploader :file, FileUploader
  def thumb_url; file.url(:thumb); end
  def photo_url; file.url; end

  after_save :percent_of_company_galery

  	def percent_of_company_galery
  		user = self.user
        @count = user.company_galeries.count
        galery_per = 0
        setting_per = UserPercentage.find_by_key('gallery').value.to_i
        if @count > 0  
        	if @count >= 10 && @count <= 30
	            @galery_per = setting_per * 0.3
	        elsif @count >= 30 &&  @count <= 50
	            @galery_per = setting_per * 0.5
	        elsif @count >= 50
	            @galery_per = setting_per * 1
	        end
            user.user_meter.update_column('galery_per' ,galery_per)
        end 
        return true
	end

end

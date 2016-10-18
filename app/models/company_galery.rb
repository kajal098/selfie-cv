class CompanyGalery < ActiveRecord::Base
	belongs_to :user
	
  mount_uploader :file, FileUploader
  def thumb_url; file.url(:thumb); end
  def photo_url; file.url; end

  after_save :percent_of_company_galery

  	def percent_of_company_galery
      user = self.user
        galery_per = 0
        setting_per = UserPercentage.find_by_key('gallery').value.to_i
        @count = user.company_galeries.count
        if user.company_galeries.count > 0  
          if @count >= 10 && @count <= 20
              galery_per = setting_per * 0.3
          elsif @count >= 20 &&  @count <= 30
              galery_per = setting_per * 0.5
          elsif @count >= 30
              galery_per = setting_per * 1
          end
        end 
        user.user_meter.update_column('galery_per' ,galery_per)
        user.profile_meter_total
        return true
    end

end

class UserReference < ActiveRecord::Base
	belongs_to :user
	validates :title, :ref_type, :from, :email, :contact, :date, :location, presence: true
	validates :contact, :numericality => true, :allow_nil => true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_ref

    def percent_of_ref()
    	user = self.user
        
        if user.user_references.count > 0  
        	ref_per = 0
            setting_per = UserPercentage.find_by_key('references').value
        	user.user_references.each do |ref|   
        	   		if ref.file_type == "image"
	                    ref_per = setting_per * 0.5
	                    break
	                elsif ref.file_type == "audio"
	                    ref_per = setting_per * 0.7
	                    break
	                elsif ref.file_type == "video"
	                    ref_per = setting_per * 1
	                    break
	                else
	                    ref_per = setting_per * 0.3
	                end
        		       	
        	end
            user.user_meter.update_column('ref_per' ,ref_per)
        end 
        
        return true
    end

end

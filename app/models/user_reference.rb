class UserReference < ActiveRecord::Base

	belongs_to :user

	validates :title, :ref_type, :from, :email, :contact, :date, :location, presence: true

	validates :contact, :numericality => true, :allow_nil => true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/
    validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/
    
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end

    after_save :percent_of_ref
    before_destroy :reduce_percentage

    def percent_of_ref()
    	user = self.user
        ref_per = 0
        if user.user_references.count > 0  
            setting_per = UserPercentage.find_by_key('references').value
        	user.user_references.each do |ref|   
        	   		if ref.file_type == "video"
	                    ref_per = setting_per.to_i * 1
	                    break
	                elsif ref.file_type == "audio"
	                    ref_per = setting_per.to_i * 0.7
	                elsif ref.file_type == "image"
	                    ref_per = setting_per.to_i * 0.5
	                else
	                    ref_per = setting_per.to_i * 0.3
	                end
        	end
        end 
        user.user_meter.update_column('ref_per' ,ref_per)
        user.profile_meter_total
        return true 
    end

    def reduce_percentage
            user = self.user
            ref_per = 0
            if user.user_references.where.not(id: self.id).count > 0 
                setting_per = UserPercentage.find_by_key('references').value
                user.user_references.where.not(id: self.id).each do |ref|   
                        if ref.file_type == "video"
                            ref_per = setting_per.to_i * 1
                            break
                        elsif ref.file_type == "audio"
                            ref_per = setting_per.to_i * 0.7
                        elsif ref.file_type == "image"
                            ref_per = setting_per.to_i * 0.5
                        else
                            ref_per = setting_per.to_i * 0.3
                        end
                end
            end
            user.user_meter.update_column('ref_per' ,ref_per)
            user.profile_meter_total
            return true 
        end



end

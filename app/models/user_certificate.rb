class UserCertificate < ActiveRecord::Base
	belongs_to :user

	validates :name, :certificate_type, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true


	mount_uploader :file, FileUploader
    def thumb_url          
            file.url(:thumb)        
    end
    def photo_url; file.url; end


    after_save :percent_of_certi
    before_destroy :reduce_percentage


    def percent_of_certi()
    	user = self.user
        
        if user.user_certificates.count > 0  
        	certi_per = 0
            setting_per = UserPercentage.where(key: 'certificate').where(ptype: user.role).first
        	user.user_certificates.each do |certi|   
        	   		if certi.file_type == "video"
	                    certi_per = setting_per.value.to_i * 1
	                    break
                    elsif certi.file_type == "image"
                        certi_per = setting_per.value.to_i * 0.7
                        break
	                elsif certi.file_type == "doc"
	                    certi_per = setting_per.value.to_i * 0.7
	                    break
	                else
	                    certi_per = setting_per.value.to_i * 0.5
	                end        		       	
        	end
            user.user_meter.update_column('certificate_per' ,certi_per)
            user.profile_meter_total
        end 
        
        return true
    end


    def reduce_percentage
        user = self.user
        certi_per = 0
        if user.user_certificates.where.not(id: self.id).count > 0 
            setting_per = UserPercentage.where(key: 'certificate').where(ptype: user.role).first
            user.user_certificates.where.not(id: self.id).each do |certi|   
                    if certi.file_type == "video"
                        certi_per = setting_per.value.to_i * 1
                        break
                    elsif certi.file_type == "image"
                        certi_per = setting_per.value.to_i * 0.7
                        break
                    elsif certi.file_type == "doc"
                        certi_per = setting_per.value.to_i * 0.7
                        break
                    else
                        certi_per = setting_per.value.to_i * 0.5
                    end                        
            end
        end
        user.user_meter.update_column('certificate_per' ,certi_per)
        user.profile_meter_total
        return true
    end






end

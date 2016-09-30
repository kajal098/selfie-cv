class UserCertificate < ActiveRecord::Base
	belongs_to :user

	validates :name, :certificate_type, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true

	after_save :percent_of_certi
	

	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end







    def percent_of_certi()
    	user = self.user
        
        if user.user_certificates.count > 0  
        	certi_per = 0
        	user.user_certificates.each do |certi|   
        	   		if 
	                    certi.file_type = "image"
	                    certi_per = 100
	                    break
	                elsif 
	                    certi.file_type = "doc"
	                    certi_per = 100
	                    break
	                else
	                    certi_per = 50
	                end
        		       	
        	end
        end 
        user.user_meter.update_column('certificate_per' ,certi_per)
        return true
    end







end

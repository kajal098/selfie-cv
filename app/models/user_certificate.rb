class UserCertificate < ActiveRecord::Base
	belongs_to :user

	validates :name, :certificate_type, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true
	

	mount_uploader :file, FileUploader
    def thumb_url
        if(file.identifier.blank?)
            ActionController::Base.helpers.asset_url("certificate.png")
        else    
            file.url(:thumb)
        end
    end
    def photo_url; file.url; end
end

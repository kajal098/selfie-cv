class UserCertificate < ActiveRecord::Base
	belongs_to :user

	validates :name, :certificate_type, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true
	#validates :year, length: { minimum: 2 }
  	#validates :year, length: { maximum: 500 }
  	#validates :year, length: { in: 6..20 }
  	#validates :year, length: { is: 6 }

	mount_uploader :file, FileUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

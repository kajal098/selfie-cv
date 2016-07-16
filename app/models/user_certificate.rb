class UserCertificate < ActiveRecord::Base
	belongs_to :user

	validates :name, :certificate_type, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true
	

	mount_uploader :file, CertificateUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

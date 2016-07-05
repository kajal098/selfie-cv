class UserEnvironment < ActiveRecord::Base
	mount_uploader :file, FileUploader
	validates :env_type,:title, presence: true
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

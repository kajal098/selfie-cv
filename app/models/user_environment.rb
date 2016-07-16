class UserEnvironment < ActiveRecord::Base
	validates :env_type,:title, presence: true
	mount_uploader :file, EnvironmentUploader	
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

class UserReference < ActiveRecord::Base
	mount_uploader :file, FileUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

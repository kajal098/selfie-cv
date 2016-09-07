class Group < ActiveRecord::Base
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
end

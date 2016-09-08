class Group < ActiveRecord::Base
	mount_uploader :group_pic, FileUploader
    def thumb_url
          
            group_pic.url(:thumb)
        
    end
end

class UserEnvironment < ActiveRecord::Base
	validates :env_type,:title, presence: true
	mount_uploader :file, FileUploader	
    def thumb_url
        if(file.identifier.blank?)
            ActionController::Base.helpers.asset_url("work.png")
        else    
            file.url(:thumb)
        end
    end
    def photo_url; file.url; end
end

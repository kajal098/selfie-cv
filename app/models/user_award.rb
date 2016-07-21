class UserAward < ActiveRecord::Base
	belongs_to :user
	validates :name,:award_type,:description, presence: true
	
	mount_uploader :file, FileUploader
    def thumb_url
        if(file.identifier.blank?)
            ActionController::Base.helpers.asset_url("award.png")
        else    
            file.url(:thumb)
        end
    end
    def photo_url; file.url; end
end

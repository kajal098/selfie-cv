class UserFutureGoal < ActiveRecord::Base
	belongs_to :user
	validates :goal_type,:title,:term_type, presence: true
	mount_uploader :file, FileUploader
    def thumb_url
        if(file.identifier.blank?)
            ActionController::Base.helpers.asset_url("goal.png")
        else    
            file.url(:thumb)
        end
    end
    def photo_url; file.url; end
end

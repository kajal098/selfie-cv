class UserFutureGoal < ActiveRecord::Base
	belongs_to :user
	validates :goal_type,:title,:term_type, presence: true
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end
end

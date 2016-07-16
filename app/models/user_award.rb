class UserAward < ActiveRecord::Base
	belongs_to :user
	validates :name,:award_type,:description, presence: true
	
	mount_uploader :file, AwardUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

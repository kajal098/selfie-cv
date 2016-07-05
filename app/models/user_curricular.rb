class UserCurricular < ActiveRecord::Base
	belongs_to :user
	validates :curricular_type,:team_type,:location,:date, presence: true
	mount_uploader :file, FileUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

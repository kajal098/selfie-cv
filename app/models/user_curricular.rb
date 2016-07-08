class UserCurricular < ActiveRecord::Base
	belongs_to :user

	validates :curricular_type,:team_type,:location,:date, presence: true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/

	mount_uploader :file, FileUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

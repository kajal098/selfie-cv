class UserExperience < ActiveRecord::Base
	validates :name,:start_from,:working_till,:designation, presence: true
	#validates_format_of :start_from, :with => /\d{2}\/\d{2}\/\d{4}/
	#validates_format_of :working_till, :with => /\d{2}\/\d{2}\/\d{4}/
	mount_uploader :file, FileUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

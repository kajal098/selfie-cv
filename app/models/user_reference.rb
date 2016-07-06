class UserReference < ActiveRecord::Base
	belongs_to :user
	validates :title, :ref_type, :from, :email, :contact, :date, :location, presence: true
	mount_uploader :file, FileUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

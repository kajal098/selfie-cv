class UserReference < ActiveRecord::Base
	belongs_to :user
	validates :title, :ref_type, :from, :email, :contact, :date, :location, presence: true
	validates :contact, :numericality => true, :allow_nil => true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/
	mount_uploader :file, ReferenceUploader
    def thumb_url; file.url(:thumb); end
    def photo_url; file.url; end
end

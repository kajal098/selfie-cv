class UserReference < ActiveRecord::Base
	belongs_to :user
	validates :title, :ref_type, :from, :email, :contact, :date, :location, presence: true
	validates :contact, :numericality => true, :allow_nil => true
	#validates_format_of :date, :with => /\d{2}\/\d{2}\/\d{4}/
	mount_uploader :file, FileUploader
    def thumb_url
        if(file.identifier.blank?)
            ActionController::Base.helpers.asset_url("ref.png")
        else    
            file.url(:thumb)
        end
    end
    def photo_url; file.url; end
end

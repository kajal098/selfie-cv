class FacultyPublication < ActiveRecord::Base

	belongs_to :user

	validates :title,:description, presence: true
	
	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end
end

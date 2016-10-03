class UserMarksheet < ActiveRecord::Base

	paginates_per 10	

	validates :school_name, :standard, :grade, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true

	mount_uploader :file, FileUploader
    def thumb_url
          
            file.url(:thumb)
        
    end
    def photo_url; file.url; end
    
end
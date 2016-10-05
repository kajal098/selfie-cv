class UserWhizquiz < ActiveRecord::Base
	belongs_to :user
	belongs_to :whizquiz
	mount_uploader :review, FileUploader
    def thumb_url
          
            review.url(:thumb)
        
    end
    def photo_url; review.url; end
end

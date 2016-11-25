class VideoUpload < ActiveRecord::Base

	validates :file, presence: { message: "Please upload file." }

	mount_uploader :file, FileUploader
    def thumb_url
         
            file.url(:thumb)
    end

    def photo_url; file.url; end
end

class VideoUpload < ActiveRecord::Base

	validates :file, presence: { message: "Please upload file." }
	mount_uploader :file, VideoUploader
    def thumb_url
        file.url(:thumb)
    end

    def photo_url; file.url; end

    extend Enumerize
	enum role: { Jobseeker: 1, Company: 2, Student:3, Faculty:4 }
	ROLES = {"Jobseeker" => 1, "Company" => 2, "Student" => 3, "Faculty" => 4}
end

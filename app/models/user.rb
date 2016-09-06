class User < ActiveRecord::Base
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable


extend Enumerize
enum role: { Admin: 0, Student: 1, Faculty: 2, Jobseeker:3, Company:4 }

devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable

validates :username,presence: true, uniqueness: { case_sensitive: false }
validates_format_of :email, :with => /\A[^@]+@([^@\.]+\.)+[^@\.]+\z/

#validates :username, length: { minimum: 6 }
#validates :username, length: { maximum: 20 }
#validates :username, length: { in: 6..20 }
#validates :username, length: { is: 6 }

paginates_per 10

has_many :devices
has_many :courses
has_many :specializations
belongs_to :company
belongs_to :industry
has_many :user_educations
has_many :student_educations
has_many :user_experiences
has_many :user_preferred_works
has_many :user_awards
has_many :user_certificates
has_many :user_curriculars
has_many :user_future_goals
has_many :user_environments
has_many :user_references
has_many :company_galeries
has_many :user_marksheets
has_one :user_meter
has_many :user_projects

mount_uploader :file, FileUploader
    # def resume_thumb_url
    # 	if(file.identifier.blank?)
    # 		ActionController::Base.helpers.asset_url("cv.png")
    # 	else	
    #  		file.url(:thumb)
    #  	end
    # end
def resume_thumb_url; file.url(:thumb); end
def resume_photo_url; file.url; end

mount_uploader :profile_pic, FileUploader
def profile_thumb_url; profile_pic.url(:thumb); end
def profile_photo_url; profile_pic.url; end

mount_uploader :company_logo, FileUploader
def logo_thumb_url
          
            file.url(:thumb)
        
    end
def logo_photo_url; company_logo.url; end

mount_uploader :company_profile, FileUploader
def company_profile_thumb_url
           
            file.url(:thumb)
        
    end
def company_profile_photo_url; company_profile.url; end

mount_uploader :company_brochure, FileUploader
def brochure_thumb_url
          
            file.url(:thumb)
        
    end
def brochure_photo_url; company_brochure.url; end

def self.to_csv(options = {})
    CSV.generate(options) do |csv|
        csv << column_names
        all.each do |user|
            csv << user.attributes.values_at(*column_names)
        end
    end
end


end

class User < ActiveRecord::Base
# Include default devise modules. Others available are:
# :confirmable, :lockable, :timeoutable and :omniauthable


extend Enumerize
enum role: { Admin: 0, Student: 1, Faculty: 2, Jobseeker:3, Company:4 }

devise :database_authenticatable, :registerable,
:recoverable, :rememberable, :trackable

validates :username,presence: true, uniqueness: { case_sensitive: false }
#validates :username, length: { minimum: 6 }
#validates :username, length: { maximum: 20 }
#validates :username, length: { in: 6..20 }
#validates :username, length: { is: 6 }

has_many :devices
has_many :user_educations
has_many :user_awards
has_many :user_certificates
has_many :user_curriculars
has_many :user_future_goals
has_many :user_environments
has_many :user_references
has_many :company_galeries
has_many :user_experiences
has_many :user_preferred_works
has_many :user_meters



mount_uploader :file, FileUploader
def resume_thumb_url; file.url(:thumb); end
def resume_photo_url; file.url; end

mount_uploader :profile_pic, FileUploader
def profile_thumb_url; profile_pic.url(:thumb); end
def profile_photo_url; profile_pic.url; end

mount_uploader :company_logo, FileUploader
def logo_thumb_url; company_logo.url(:thumb); end
def logo_photo_url; company_logo.url; end

mount_uploader :company_profile, FileUploader
def company_profile_thumb_url; company_profile.url(:thumb); end
def company_profile_photo_url; company_profile.url; end

mount_uploader :company_brochure, FileUploader
def brochure_thumb_url; company_brochure.url(:thumb); end
def brochure_photo_url; company_brochure.url; end



TITLES = 
[
  ['Mr', 'Mr'] ,
  ['Miss' , 'Miss' ],
  ['Mrs' , 'Mrs' ] 
]
end

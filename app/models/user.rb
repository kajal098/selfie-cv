class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
		extend Enumerize
        
        enum role: { Admin: 0, Student: 1, Faculty: 2, Jobseeker:3, Company:10 }

        devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

        validates :username,presence: true, uniqueness: { case_sensitive: false }

        has_many :devices
        has_many :user_educations
        has_many :user_awards
        has_many :user_certificates
        has_many :user_curriculars
        has_many :user_future_goals
        has_many :user_environments
        has_many :user_references

mount_uploader :file, FileUploader
  def resume_thumb_url; file.url(:thumb); end
  def resume_photo_url; file.url; end

mount_uploader :profile_pic, FileUploader
  def profile_thumb_url; profile_pic.url(:thumb); end
  def profile_photo_url; profile_pic.url; end

  

TITLES = 
  [
    ['Mr', 'Mr'] ,
    ['Miss' , 'Miss' ],
    ['Mrs' , 'Mrs' ] 
    ]

end

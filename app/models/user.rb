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
        has_many :awards
        has_many :certificates
        has_many :user_curriculars

mount_uploader :file, FileUploader
  def thumb_url; file.url(:thumb); end
  def photo_url; file.url; end

TITLES = 
  [
    ['Mr', 'Mr'] ,
    ['Miss' , 'Miss' ],
    ['Mrs' , 'Mrs' ] 
    ]

end

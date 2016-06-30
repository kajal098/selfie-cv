class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
		extend Enumerize
        
        enum role: { Student: 0, Faculty: 1, Jobseeker:2, Company:10 }

        devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

        validates :username,presence: true, uniqueness: { case_sensitive: false }

        has_many :devices

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

class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
		extend Enumerize
        
        enum role: { user: 0, admin: 10 }

        devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable

        validates :username,presence: true, uniqueness: { case_sensitive: false }

        has_many :devices


TITLES = 
  [
    ['Mr', 'Mr'] ,
    ['Miss' , 'Miss' ],
    ['Mrs' , 'Mrs' ] 
    ]

end

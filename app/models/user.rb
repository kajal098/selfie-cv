class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  
		extend Enumerize
        
        enum role: { user: 0, admin: 10 }

        devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

        validates :username,presence: true, uniqueness: { case_sensitive: false }

        has_many :devices
        
end

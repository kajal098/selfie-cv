class Group < ActiveRecord::Base
	mount_uploader :group_pic, FileUploader
    def thumb_url
          
            group_pic.url(:thumb)
        
    end
    def photo_url; group_pic.url; end

    before_validation :set_slug

    def set_slug 
        self.slug = name.parameterize
    end

    def self.search(search)
        if search
          where(['name ILIKE ?', "%#{search}%"])
        else
          scoped
        end
    end

    validates :slug, presence: true
    validates_uniqueness_of :slug, message: "Group Name is already exists"

    paginates_per 10
    
    belongs_to :user
    has_many :chats

    has_many :users, class_name: 'GroupUser'
    scope :fetch_groups, -> (user) {where("#{user.id} != ALL (deleted_from)").all}

    has_many :accepted_users, ->{ where("group_users.status = ?", GroupUser.statuses[:joined]) }, class_name: 'GroupUser', source: :group_user

end

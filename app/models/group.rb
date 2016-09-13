class Group < ActiveRecord::Base
	mount_uploader :group_pic, FileUploader
    def thumb_url
          
            group_pic.url(:thumb)
        
    end
    def photo_url; group_pic.url; end

    paginates_per 10
    
    belongs_to :user
    has_many :chats

    has_many :users, class_name: 'GroupUser'
    scope :fetch_groups, -> (user) {where("#{user.id} != ALL (deleted_from)").all}

end

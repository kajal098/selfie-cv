class Group < ActiveRecord::Base
	mount_uploader :group_pic, FileUploader
    def thumb_url
          
            group_pic.url(:thumb)
        
    end

    paginates_per 10
    
    belongs_to :user
    has_many :users, class_name: 'GroupUser'
    scope :fetch_groups, -> (user) {where("#{user.id} != ALL (deleted_from)").all}

end

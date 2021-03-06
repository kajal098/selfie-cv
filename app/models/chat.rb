class Chat < ActiveRecord::Base
	belongs_to :user, class_name: 'User',foreign_key: "sender_id"
	belongs_to :chat_schedule, class_name: 'ChatSchedule',foreign_key: "chat_schedule_id"

	mount_uploader :file, FileUploader
    def thumb_url          
            file.url(:thumb)        
    end
	def photo_url; file.url; end

	scope :count_unread, -> (group, user) {where("group_id = #{group.id}").where("#{user.id} != ALL (user_ids)").where("created_at >= ?", user.updated_at).count}
	#scope :count_unread, -> (group, user, member) {where("group_id = #{group.id}").where("#{user.id} != ALL (user_ids)").where("#{user.id} != ALL (deleted_from)").where("created_at >= ?", member.updated_at).count}
	scope :last_message, -> (group, user) {where("group_id = #{group}").where("#{user.id} != ALL (deleted_from)").last}

end

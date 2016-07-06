class UserMeter < ActiveRecord::Base
	belongs_to :user
	after_create :one_method
	def one_method
  		user_meter = UserMeter.create(:user_id=>[user.id],
                            :resume_per=>[self.resume_per],:acievement_per=>[self.acievement_per],
                            :curri_per=>[self.curri_per],:lifegoal_per=>[self.lifegoal_per],:working_per=>[self.working_per],:ref_per=>[self.ref_per])
	end
end

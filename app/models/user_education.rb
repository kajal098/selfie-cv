class UserEducation < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	belongs_to :specialization
	
	validates :course_id, :specialization_id,  :year, :school, :skill, presence: true
	validates :year, :numericality => true, :allow_nil => true

	
	
end

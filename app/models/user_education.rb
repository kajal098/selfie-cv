class UserEducation < ActiveRecord::Base
	belongs_to :user
	belongs_to :course
	belongs_to :specialization
end

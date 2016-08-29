class StudentEducation < ActiveRecord::Base
	belongs_to :user, :class_name => "User", :foreign_key => 'user_id'
	belongs_to :standard, :class_name => "Standard", :foreign_key => 'standard_id'

	validates :year, :school, presence: true
	validates :year, :numericality => true, :allow_nil => true
end

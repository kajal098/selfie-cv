class FacultyAffiliation < ActiveRecord::Base

	belongs_to :user

	validates :university,:collage_name,:subject,:designation,:join_from, presence: true
	
	
end

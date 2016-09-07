class FacultyAffiliation < ActiveRecord::Base

	belongs_to :user

	validates :collage_name,:subject,:designation,:join_from, presence: true
	
	
end

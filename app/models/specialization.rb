class Specialization < ActiveRecord::Base

	paginates_per 10

	validates :name, presence: true
	
end
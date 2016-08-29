class UserMarksheet < ActiveRecord::Base

	paginates_per 10	

	validates :school_name, :standard, :grade, :year, presence: true
	validates :year, :numericality => true, :allow_nil => true

end
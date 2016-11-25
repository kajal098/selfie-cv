class Company < ActiveRecord::Base

	paginates_per 10

	validates :name, presence: { message: "Name must be filled" }
	
end

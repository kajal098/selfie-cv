class Company < ActiveRecord::Base

	paginates_per 10

	validates :name, presence: { message: "Company name must be filled" }
	
end

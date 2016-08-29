class UserProject < ActiveRecord::Base

	paginates_per 10	

	validates :title, :description, presence: true

end

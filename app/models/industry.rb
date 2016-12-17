class Industry < ActiveRecord::Base

	validates :name, presence: { message: "Industry name must be filled" }

	has_many :marketiqs, class_name: 'Marketiq',foreign_key: "industry_id"

	has_many :graphs, class_name: 'Graph',foreign_key: "industry_id"

	paginates_per 10
	
end

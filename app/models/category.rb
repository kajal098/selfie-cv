class Category < ActiveRecord::Base

	paginates_per 10

	validates :name, presence: true

	has_many :marketiqs, class_name: 'Marketiq',foreign_key: "category_id"
	
end

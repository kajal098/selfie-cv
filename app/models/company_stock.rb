class CompanyStock < ActiveRecord::Base

	has_many :graphs, class_name: 'Graph',foreign_key: "company_stock_id"
	has_many :users, class_name: 'User',foreign_key: "country_id"
	belongs_to :category, class_name: 'Category',foreign_key: "category_id"

end

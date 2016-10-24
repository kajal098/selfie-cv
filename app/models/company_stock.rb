class CompanyStock < ActiveRecord::Base

	has_many :graphs, class_name: 'Graph',foreign_key: "company_stock_id"

end

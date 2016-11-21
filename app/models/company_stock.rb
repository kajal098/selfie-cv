class CompanyStock < ActiveRecord::Base

	has_many :graphs, class_name: 'Graph',foreign_key: "company_stock_id"
	has_many :company_stocks, class_name: 'CompanyStock',foreign_key: "country_id"

end

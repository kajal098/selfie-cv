class CompanyStock < ActiveRecord::Base

	has_many :graphs, class_name: 'Graph',foreign_key: "company_stock_id"
	has_many :users, class_name: 'User',foreign_key: "country_id"
	belongs_to :category, class_name: 'Category',foreign_key: "category_id"
	belongs_to :stock_country, class_name: 'StockCountry',foreign_key: "stock_country_id"

	validates :category_id, presence: { message: "Category must be filled" }
	validates :stock_country_id,  presence: { message: "Country must be filled" }
	validates :sensex,  presence: { message: "Sensex must be filled" }
	validates :company_code,  presence: { message: "Company code must be filled" }
	validates :currency,  presence: { message: "Currency must be filled" }
	validates :date_format,  presence: { message: "Date Format must be filled" }

end

class CompanyStock < ActiveRecord::Base

	has_many :graphs, class_name: 'Graph',foreign_key: "company_stock_id"
	has_many :users, class_name: 'User',foreign_key: "country_id"
	belongs_to :category, class_name: 'Category',foreign_key: "category_id"

	validates :category_id, presence: { message: "Category must be filled" }
	validates :sensex_co,  presence: { message: "Country must be filled" }
	validates :sensex,  presence: { message: "Sensex must be filled" }
	validates :currency,  presence: { message: "Currency must be filled" }
	validates :date_format,  presence: { message: "Date Format must be filled" }

end

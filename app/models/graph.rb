class Graph < ActiveRecord::Base

	belongs_to :industry, class_name: "Industry", foreign_key: "industry_id"

	belongs_to :company_stock, class_name: "CompanyStock", foreign_key: "company_stock_id"

	validates :company_code, presence: { message: "hahaha" }
	
	validates :industry_id, presence: { message: "industry must be filled" }

	validates :company_stock_id, presence: { message: "country must be filled" }

end
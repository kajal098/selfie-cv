class StockCountry < ActiveRecord::Base
	has_many    :users
	has_many    :company_stocks
	before_save :downcase_fields

	validates :name, presence: { message: "Country name must be filled" }

	def downcase_fields
      self.name.downcase!
   	end

   	paginates_per 10
   	
end

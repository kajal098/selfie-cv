class StockCountry < ActiveRecord::Base
	has_many    :users
	has_many    :company_stocks
	before_save :downcase_fields

	def downcase_fields
      self.name.downcase!
   end
end

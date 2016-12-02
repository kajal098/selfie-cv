class StockCountry < ActiveRecord::Base
	has_many    :users
	has_many    :company_stocks
end

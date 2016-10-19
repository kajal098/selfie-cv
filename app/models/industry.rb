class Industry < ActiveRecord::Base

	validates :name, presence: true

	has_many :marketiqs, class_name: 'Marketiq',foreign_key: "industry_id"
	
end

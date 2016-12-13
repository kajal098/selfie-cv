class Specialization < ActiveRecord::Base

	paginates_per 10

	validates :name, presence: { message: "Specialization name must be filled" }

	has_many :marketiqs, class_name: 'Marketiq',foreign_key: "specialization_id"
	
end
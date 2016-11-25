class Category < ActiveRecord::Base
	has_many :categories
	validates :name, presence: { message: "Name must be filled" }
end

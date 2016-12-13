class Category < ActiveRecord::Base
	has_many :categories
	validates :name, presence: { message: "Category name must be filled" }
	before_save :downcase_fields

   def downcase_fields
      self.name.downcase!
   end
end

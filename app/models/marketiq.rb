class Marketiq < ActiveRecord::Base

	
validates :question, presence: { message: "Question must be filled" }
validates :option_a, presence: { message: "Option A must be filled" }
validates :option_b, presence: { message: "Option B must be filled" }
validates :option_c, presence: { message: "Option C must be filled" }
validates :option_d, presence: { message: "Option D must be filled" }
validates :answer, presence: { message: "Answer must be filled" }


	paginates_per 10

	belongs_to :industry, class_name: "Industry", foreign_key: "industry_id"

	belongs_to :specialization, class_name: "Specialization", foreign_key: "specialization_id"

	extend Enumerize
	enum role: { Jobseeker: 1, Company: 2, Student:3, Faculty:4 }

end

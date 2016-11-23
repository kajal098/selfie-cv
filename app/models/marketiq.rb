class Marketiq < ActiveRecord::Base

	validates :question, :option_a, :option_b, :option_c, :option_d, :answer, presence: true

	paginates_per 10

	belongs_to :industry, class_name: "Industry", foreign_key: "industry_id"

	belongs_to :specialization, class_name: "Specialization", foreign_key: "specialization_id"

	extend Enumerize
	enum role: { Jobseeker: 1, Company: 2, Student:3, Faculty:4 }

end

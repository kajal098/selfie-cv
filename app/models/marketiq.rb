class Marketiq < ActiveRecord::Base

	
validates :question, presence: { message: "Question must be filled" }
validates :option_a, presence: { message: "Option A must be filled" }
validates :option_b, presence: { message: "Option B must be filled" }
validates :option_c, presence: { message: "Option C must be filled" }
validates :option_d, presence: { message: "Option D must be filled" }
validates :answer, presence: { message: "Answer must be filled" }
validates_presence_of :specialization_id, :if => :check_jobseeker?, message: "specialization_id must be filled"
validates_presence_of :industry_id, :if => :check_company?, message:"industry_id must be filled"
validates_presence_of :award_name, :if => :check_student?, message: "award_name must be filled"
validates_presence_of :subject, :if => :check_faculty?, message: "subject must be filled"


def check_jobseeker?
  role == "Jobseeker"
end
def check_company?
	role == "Company"
end
def check_student? 
	role == "Student"
end

def check_faculty? 
	role == "Faculty"
end

	paginates_per 7

	belongs_to :industry, class_name: "Industry", foreign_key: "industry_id"

	belongs_to :specialization, class_name: "Specialization", foreign_key: "specialization_id"

	extend Enumerize
	enum role: { Jobseeker: 1, Company: 2, Student:3, Faculty:4 }

end

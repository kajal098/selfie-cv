class Whizquiz < ActiveRecord::Base

	validates :question, presence: { message: "Question must be filled" }
	validates :answer, presence: { message: "Answer must be filled" }

	paginates_per 10
	
end

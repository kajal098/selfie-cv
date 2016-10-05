if @questions
		json.time_for_ans 10

	json.questions @questions do |question|
		json.extract! question, :id, :question


		json.created_at question.created_at.to_i
		json.updated_at question.updated_at.to_i
	end
end
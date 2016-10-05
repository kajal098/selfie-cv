if @questions

json.time_for_ans 10

	json.questions @questions do |question|
		json.extract! question, :id, :question
		json.created_at question.created_at.to_i
		json.updated_at question.updated_at.to_i
	end
end

if @user_whizquiz
	json.user_whizquizzes @user.user_whizquizzes do |user_whizquiz|
		json.extract! user_whizquiz, :id, :user_id, :whizquiz_id, :review
		json.created_at user_whizquiz.created_at.to_i
		json.updated_at user_whizquiz.updated_at.to_i
	end
end
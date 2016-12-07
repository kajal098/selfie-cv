json.status "Success"

if @marketiq
	json.time_for_ans Setting.first.marketiq_time.to_i
	json.id_for_marketiq @user_marketiq.id
	json.marketiq @marketiq, :question, :option_a, :option_b, :option_c, :option_d, :answer
	json.created_at @marketiq.created_at.to_i
	json.updated_at @marketiq.updated_at.to_i
end

if @answer_user_marketiq
	json.answer_user_marketiq @answer_user_marketiq, :id, :answer, :status
	json.created_at @answer_user_marketiq.created_at.to_i
	json.updated_at @answer_user_marketiq.updated_at.to_i
end

if @user_marketiqs
	json.user_marketiqs @user_marketiqs do |user_marketiq|		
		json.id user_marketiq.id
		json.question user_marketiq.marketiq.question
		json.option_a user_marketiq.marketiq.option_a
		json.option_b user_marketiq.marketiq.option_b
		json.option_c user_marketiq.marketiq.option_c
		json.option_d user_marketiq.marketiq.option_d
		json.answer user_marketiq.marketiq.answer
		json.submitted_answer user_marketiq.answer
		json.status user_marketiq.status
		json.created_at user_marketiq.created_at.to_i
		json.updated_at user_marketiq.updated_at.to_i
	end
end

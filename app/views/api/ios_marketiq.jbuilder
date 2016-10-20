if @marketiq
	json.time_for_ans 60
	json.marketiq @marketiq, :id, :question, :option_a, :option_b, :option_c, :option_d
	json.created_at @marketiq.created_at.to_i
	json.updated_at @marketiq.updated_at.to_i
end

if @answer_user_marketiq
	json.answer_user_marketiq @answer_user_marketiq, :id, :answer
	json.created_at @answer_user_marketiq.created_at.to_i
	json.updated_at @answer_user_marketiq.updated_at.to_i
end

if @user_marketiqs
	json.user_marketiqs @user_marketiqs do |user_marketiq|
		json.extract! user_marketiq, :id, :answer
		json.created_at user_marketiq.created_at.to_i
		json.updated_at user_marketiq.updated_at.to_i
	end
end

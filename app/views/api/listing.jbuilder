if @user_educations
	json.user_educations @user.user_educations do |education|
	json.extract! education, :id, :user_id, :course_id, :specialization_id, :year, :school, :skill

	json.edu_created_at education.created_at.to_i
	json.edu_updated_at education.updated_at.to_i
end
end

if @user_experiences
	json.user_experiences @user.user_experiences do |experience|
	json.extract! experience, :id, :user_id, :name, :start_from, :working_till, :designation

	json.edu_created_at experience.created_at.to_i
	json.edu_updated_at experience.updated_at.to_i
end
end

if @user_preferred_works
	json.user_preferred_works @user.user_preferred_works do |user_preferred_work|
		json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type

		json.created_at user_preferred_work.created_at.to_i
		json.updated_at user_preferred_work.updated_at.to_i
	end
end

if @user_awards
	json.awards @user.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description, :award_type
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
	end
end

if @user_certificates
	json.certificates @user.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year

		json.file certificate.thumb_url

		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
	end
end


if @user_curriculars
	json.user_curriculars @user.user_curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date

		json.file curricular.thumb_url

		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
	end
end

if @user_future_goals
	json.user_future_goals @user.user_future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type

		json.file future_goal.thumb_url

		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
	end
end

if @user_working_environments
	json.user_working_environments @user.user_environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title

		json.file environment.thumb_url

		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
	end
end


if @user_references
	json.user_references @user.user_references do |env|
		json.extract! env, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location

		json.file env.thumb_url

		json.env_created_at env.created_at.to_i
		json.env_updated_at env.updated_at.to_i
	end
end
if @user
	if @user.role == 'Jobseeker'
		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :education_in, :school_name, :year

		json.profile @user.profile_thumb_url

		json.resume @user.resume_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
	else if @user.role == 'Company'
		json.User @user, :id, :company_name, :company_establish_from, :company_industry, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :companu_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.logo @user.logo_thumb_url

		json.profile @user.company_profile_thumb_url

		json.brochure @user.brochure_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
	end
	end
	
end


if @user_education
	json.educations @user.user_educations do |education|
	json.extract! education, :id, :user_id, :course_id, :specialization_id, :year, :school, :skill

	json.edu_created_at education.created_at.to_i
	json.edu_updated_at education.updated_at.to_i
end
end


if @award
	json.awards @user.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
	end
end


if @certificate
	json.certificates @user.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year

		json.file certificate.thumb_url

		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
	end
end


if @curricular
	json.curriculars @user.user_curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date

		json.file curricular.thumb_url

		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
	end
end

if @future_goal
	json.future_goals @user.user_future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type

		json.file future_goal.thumb_url

		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
	end
end

if @environment
	json.environments @user.user_environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title

		json.file environment.thumb_url

		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
	end
end


if @reference
	json.environments @user.user_references do |env|
		json.extract! env, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location

		json.file env.thumb_url

		json.env_created_at env.created_at.to_i
		json.env_updated_at env.updated_at.to_i
	end
end

if @courses
	json.courses @courses do |course|
		json.extract! course, :id, :name

		json.course_created_at course.created_at.to_i
		json.course_updated_at course.updated_at.to_i
	end
end

if @specializations
	json.specializations @specializations do |specialization|
		json.extract! specialization, :id, :name

		json.specialization_created_at specialization.created_at.to_i
		json.specialization_updated_at specialization.updated_at.to_i
	end
end



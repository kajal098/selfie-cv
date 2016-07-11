if @user
	if @user.role == 'Jobseeker'
		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number

		json.profile @user.profile_thumb_url

		json.resume @user.resume_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

	elsif @user.role == 'Company'
		json.User @user, :id, :company_name, :company_establish_from, :company_industry, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id, :company_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.logo @user.logo_thumb_url

		json.profile @user.company_profile_thumb_url

		json.brochure @user.brochure_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
		
	end
end


if @user_education
	json.educations @user.user_educations do |education|
	json.extract! education, :id, :user_id, :course_id, :specialization_id, :year, :school, :skill

	json.created_at education.created_at.to_i
	json.updated_at education.updated_at.to_i
end
end

if @users
	json.users @users do |user|
	json.extract! user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number

	json.profile user.profile_thumb_url

	json.resume user.resume_thumb_url

	json.created_at user.created_at.to_i
	json.updated_at user.updated_at.to_i
end
end




if @user_experience
	json.experiences @user.user_experiences do |experience|
		json.extract! experience, :id, :user_id, :name, :start_from, :working_till, :designation

		json.file experience.thumb_url

		json.created_at experience.created_at.to_i
		json.updated_at experience.updated_at.to_i
	end
end

if @user_preferred_work
	json.user_preferred_works @user.user_preferred_works do |user_preferred_work|
		json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type

		json.created_at user_preferred_work.created_at.to_i
		json.updated_at user_preferred_work.updated_at.to_i
	end
end

if @award
	json.awards @user.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description, :award_type
		json.created_at award.created_at.to_i
		json.updated_at award.updated_at.to_i
	end
end

if @certificate
	json.certificates @user.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year

		json.file certificate.thumb_url

		json.created_at certificate.created_at.to_i
		json.updated_at certificate.updated_at.to_i
	end
end


if @curricular
	json.curriculars @user.user_curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date

		json.file curricular.thumb_url

		json.created_at curricular.created_at.to_i
		json.updated_at curricular.updated_at.to_i
	end
end

if @future_goal
	json.future_goals @user.user_future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type

		json.file future_goal.thumb_url

		json.created_at future_goal.created_at.to_i
		json.updated_at future_goal.updated_at.to_i
	end
end

if @environment
	json.environments @user.user_environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title

		json.file environment.thumb_url

		json.created_at environment.created_at.to_i
		json.updated_at environment.updated_at.to_i
	end
end


if @reference
	json.references @user.user_references do |ref|
		json.extract! ref, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location

		json.file ref.thumb_url

		json.created_at ref.created_at.to_i
		json.updated_at ref.updated_at.to_i
	end
end

if @courses
	json.courses @courses do |course|
		json.extract! course, :id, :name

		json.created_at course.created_at.to_i
		json.updated_at course.updated_at.to_i
	end
end

if @specializations
	json.specializations @specializations do |specialization|
		json.extract! specialization, :id, :name

		json.created_at specialization.created_at.to_i
		json.updated_at specialization.updated_at.to_i
	end
end

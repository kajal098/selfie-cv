if @user
	if @user.role == 'Jobseeker'
		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number

		json.profile @user.profile_thumb_url

		json.resume @user.resume_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.user_resume_per @user.user_meter.resume_per.to_i
		json.user_achievement_per @user.user_meter.achievement_per.to_i
		json.user_curricular_per @user.user_meter.curri_per.to_i
		json.user_lifegoal_per @user.user_meter.lifegoal_per.to_i
		json.user_working_environment_per @user.user_meter.working_per.to_i
		json.user_reference_per @user.user_meter.ref_per.to_i

	elsif @user.role == 'Company'
		json.User @user, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country,  :company_contact, :company_skype_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.logo @user.logo_thumb_url

		json.profile @user.company_profile_thumb_url

		json.brochure @user.brochure_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.company_id @user.company ? @user.company_id : ""
		json.company @user.company ? @user.company.name : ""

		json.industry_id @user.industry ? @user.industry_id : ""
		json.industry @user.industry ? @user.industry.name : ""
		

		json.user_resume_per @user.user_meter.resume_per.to_i
		json.user_achievement_per @user.user_meter.achievement_per.to_i
		json.user_curricular_per @user.user_meter.curri_per.to_i
		json.user_lifegoal_per @user.user_meter.lifegoal_per.to_i
		json.user_working_environment_per @user.user_meter.working_per.to_i
		json.user_reference_per @user.user_meter.ref_per.to_i

	elsif @user.role == 'Student'
		json.User @user, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number

		json.profile @user.profile_thumb_url

		json.file @user.resume_thumb_url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i
		
	end
end

if @company
	
		json.User @company, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country, :company_contact, :company_skype_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.logo @company.logo_thumb_url		

		json.profile @company.company_profile_thumb_url

		json.brochure @company.brochure_thumb_url

		json.company_id @company.company ? @company.company_id : ""
		json.company @company.company ? @company.company.name : ""

		json.industry_id @company.industry ? @company.industry_id : ""
		json.industry @company.industry ? @company.industry.name : ""

		json.created_at @company.created_at.to_i
		json.updated_at @company.updated_at.to_i

		json.user_resume_per @company.user_meter.resume_per.to_i
		json.user_achievement_per @company.user_meter.achievement_per.to_i
		json.user_curricular_per @company.user_meter.curri_per.to_i
		json.user_lifegoal_per @company.user_meter.lifegoal_per.to_i
		json.user_working_environment_per @company.user_meter.working_per.to_i
		json.user_reference_per @company.user_meter.ref_per.to_i
		
	
end


if @users
@all_users = @users.order('created_at DESC')
	json.users @all_users do |user|
	json.extract! user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number

	json.profile user.profile_thumb_url

	json.resume user.resume_thumb_url

	json.created_at user.created_at.to_i
	json.updated_at user.updated_at.to_i

	json.user_resume_per user.user_meter.resume_per.to_i
	json.user_achievement_per user.user_meter.achievement_per.to_i
	json.user_curricular_per user.user_meter.curri_per.to_i
	json.user_lifegoal_per user.user_meter.lifegoal_per.to_i
	json.user_working_environment_per user.user_meter.working_per.to_i
	json.user_reference_per user.user_meter.ref_per.to_i
end
end


if @user_education
@educations = @user.user_educations.order('created_at DESC')
	json.educations @educations do |education|
		json.extract! education, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
		json.course education.course.name
		json.specialization education.specialization.name

		json.edu_created_at education.created_at.to_i
		json.edu_updated_at education.updated_at.to_i
	end
end

if @user_experience
@experiences = @user.user_experiences.order('created_at DESC')
	json.experiences @experiences do |experience|
		json.extract! experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company

		json.file experience.thumb_url

		json.experience_created_at experience.created_at.to_i
		json.experience_updated_at experience.updated_at.to_i
	end
end

if @user_preferred_work
@preferred_works = @user.user_preferred_works.order('created_at DESC')
	json.user_preferred_works @preferred_works do |user_preferred_work|
		json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type

		json.created_at user_preferred_work.created_at.to_i
		json.updated_at user_preferred_work.updated_at.to_i
	end
end

if @award
@awards = @user.user_awards.order('created_at DESC')
	json.awards @awards do |award|
		json.extract! award, :id, :user_id, :name, :description

		json.file award.thumb_url
		
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
	end
end

if @certificate
@certificates = @user.user_certificates.order('created_at DESC')
	json.certificates @certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year

		json.file certificate.thumb_url

		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
	end
end


if @curricular
@curriculars = @user.user_curriculars.order('created_at DESC')
	json.curriculars @curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date

		json.file curricular.thumb_url

		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
	end
end

if @future_goal
@future_goals = @user.user_future_goals.order('created_at DESC')
	json.future_goals @future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type

		json.file future_goal.thumb_url

		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
	end
end

if @environment
@environments = @user.user_environments.order('created_at DESC')
	json.environments @environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title

		json.file environment.thumb_url

		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
	end
end


if @reference
@references = @user.user_references.order('created_at DESC')
	json.references @references do |env|
		json.extract! env, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location

		json.file env.thumb_url

		json.env_created_at env.created_at.to_i
		json.env_updated_at env.updated_at.to_i
	end
end

if @courses
@all_courses = @courses.order('created_at DESC')
	json.courses @all_courses do |course|
		json.extract! course, :id, :name

		json.course_created_at course.created_at.to_i
		json.course_updated_at course.updated_at.to_i
	end
end

if @industries
@all_industries = @industries.order('created_at DESC')
	json.industries @all_industries do |industry|
		json.extract! industry, :id, :name

		json.industry_created_at industry.created_at.to_i
		json.industry_updated_at industry.updated_at.to_i
	end
end

if @companies
@all_companies = @companies.order('created_at DESC')
	json.companies @all_companies do |company|
		json.extract! company, :id, :name

		json.company_created_at company.created_at.to_i
		json.company_updated_at company.updated_at.to_i
	end
end



if @specializations
@all_specializations = @specializations.order('created_at DESC')
	json.specializations @all_specializations do |specialization|
		json.extract! specialization, :id, :name

		json.specialization_created_at specialization.created_at.to_i
		json.specialization_updated_at specialization.updated_at.to_i
	end
end

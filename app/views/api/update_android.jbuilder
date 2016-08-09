json.status "Success"

if @user_education
	json.extract! @user_education, :id, :user_id, :year, :school, :skill
	json.course @user_education.course.name
	json.specialization @user_education.specialization.name

	json.created_at @user_education.created_at.to_i
	json.updated_at @user_education.updated_at.to_i
end

if @user_experience
	json.extract! @user_experience, :id, :user_id, :name, :start_from, :working_till, :designation

	json.file @user_experience.thumb_url

	json.created_at @user_experience.created_at.to_i
	json.updated_at @user_experience.updated_at.to_i
end

if @user_preferred_work
	json.extract! @user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type

		json.created_at @user_preferred_work.created_at.to_i
		json.updated_at @user_preferred_work.updated_at.to_i
end

if @user_award
	json.extract! @user_award, :id, :user_id, :name, :description
	
		json.created_at @user_award.created_at.to_i
		json.updated_at @user_award.updated_at.to_i
end

if @user_certificate
	json.extract! @user_certificate, :id, :user_id, :certificate_type, :name, :year

		json.file @user_certificate.thumb_url

		json.created_at @user_certificate.created_at.to_i
		json.updated_at @user_certificate.updated_at.to_i
end

if @user_curricular
	json.extract! @user_curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date

		json.file @user_curricular.thumb_url

		json.created_at @user_curricular.created_at.to_i
		json.updated_at @user_curricular.updated_at.to_i
end

if @future_goal
	json.extract! @future_goal, :id, :user_id, :goal_type, :title, :term_type

		json.file @future_goal.thumb_url

		json.created_at @future_goal.created_at.to_i
		json.updated_at @future_goal.updated_at.to_i
end

if @environment
	json.extract! @environment, :id, :user_id, :env_type, :title

		json.file @environment.thumb_url

		json.created_at @environment.created_at.to_i
		json.updated_at @environment.updated_at.to_i
end


if @reference
	json.extract! @reference, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location

		json.file @reference.thumb_url

		json.created_at @reference.created_at.to_i
		json.updated_at @reference.updated_at.to_i
end

if @company
	
		json.Company @company, :id, :username, :role, :company_name, :company_establish_from, :industry_id, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country, :company_contact, :company_skype_id, :company_type_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet

		json.logo @company.logo_thumb_url		

		json.profile @company.company_profile_thumb_url

		json.brochure @company.brochure_thumb_url

		json.created_at @company.created_at.to_i
		json.updated_at @company.updated_at.to_i

		json.user_resume_per @company.user_meter.resume_per.to_i
		json.user_achievement_per @company.user_meter.acievement_per.to_i
		json.user_curricular_per @company.user_meter.curri_per.to_i
		json.user_lifegoal_per @company.user_meter.lifegoal_per.to_i
		json.user_working_environment_per @company.user_meter.working_per.to_i
		json.user_reference_per @company.user_meter.ref_per.to_i
		
	
end
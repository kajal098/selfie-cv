if @user_stuff
	if @user_stuff.role == 'Jobseeker'
		json.User @user_stuff, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :file_type, :text_field

		json.profile @user_stuff.profile_thumb_url

		json.resume @user_stuff.resume_thumb_url

		json.created_at @user_stuff.created_at.to_i
		json.updated_at @user_stuff.updated_at.to_i

		json.jobseeker_educations @user_stuff.user_educations do |education|
		json.extract! education, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
		json.course education.course.name
		json.specialization education.specialization.name
		json.edu_created_at education.created_at.to_i
		json.edu_updated_at education.updated_at.to_i
		end

		json.jobseeker_experiences @user_stuff.user_experiences do |experience|
		json.extract! experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company
		json.file experience.thumb_url
		json.experience_created_at experience.created_at.to_i
		json.experience_updated_at experience.updated_at.to_i
		end

		json.jobseeker_preferred_works @user_stuff.user_preferred_works do |user_preferred_work|
		json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type
		json.created_at user_preferred_work.created_at.to_i
		json.updated_at user_preferred_work.updated_at.to_i
		end

		json.jobseeker_awards @user_stuff.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description
		json.file award.thumb_url		
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
		end

		json.jobseeker_certificates @user_stuff.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year
		json.file certificate.thumb_url
		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
		end

		json.jobseeker_curriculars @user_stuff.user_curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date
		json.file curricular.thumb_url
		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
		end

		json.jobseeker_future_goals @user_stuff.user_future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type
		json.file future_goal.thumb_url
		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
		end

		json.jobseeker_environments @user_stuff.user_environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title
		json.file environment.thumb_url
		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
		end

		json.jobseeker_references @user_stuff.user_references do |env|
		json.extract! env, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location
		json.file env.thumb_url
		json.env_created_at env.created_at.to_i
		json.env_updated_at env.updated_at.to_i
		end

		json.user_resume_per @user_stuff.user_meter.resume_per.to_i
		json.user_achievement_per @user_stuff.user_meter.achievement_per.to_i
		json.user_curricular_per @user_stuff.user_meter.curri_per.to_i
		json.user_lifegoal_per @user_stuff.user_meter.lifegoal_per.to_i
		json.user_working_environment_per @user_stuff.user_meter.working_per.to_i
		json.user_reference_per @user_stuff.user_meter.ref_per.to_i
		json.user_whizquiz_per @user_stuff.user_meter.whizquiz_per.to_i
		json.user_total_per @user_stuff.user_meter.total_per.to_i
		
	elsif @user_stuff.role == 'Company'
		json.User @user_stuff, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country,  :company_contact, :company_skype_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :file_type, :text_field

		json.logo @user_stuff.logo_thumb_url

		json.profile @user_stuff.company_profile_thumb_url

		json.brochure @user_stuff.brochure_thumb_url

		json.created_at @user_stuff.created_at.to_i
		json.updated_at @user_stuff.updated_at.to_i

		json.company_id @user_stuff.company ? @user_stuff.company_id : ""
		json.company @user_stuff.company ? @user_stuff.company.name : ""

		json.industry_id @user_stuff.industry ? @user_stuff.industry_id : ""
		json.industry @user_stuff.industry ? @user_stuff.industry.name : ""

		json.company_awards @user_stuff.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description
		json.file award.thumb_url		
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
		end

		json.company_certificates @user_stuff.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year
		json.file certificate.thumb_url
		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
		end

		json.company_environments @user_stuff.user_environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title
		json.file environment.thumb_url
		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
		end
		

		json.company_info_per @user_stuff.user_meter.company_info_per.to_i
		json.company_corporate_identity_per @user_stuff.user_meter.corporate_identity_per.to_i
		json.company_growth_and_goal_per @user_stuff.user_meter.growth_and_goal_per.to_i
		json.company_tribute_per @user_stuff.user_meter.company_tribute_per.to_i
		json.company_gallery_per @user_stuff.user_meter.galery_per.to_i
		json.company_working_env_per @user_stuff.user_meter.working_env_per.to_i
		json.user_total_per @user_stuff.user_meter.total_per.to_i

	elsif @user_stuff.role == 'Student'
		json.User @user_stuff, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :file_type, :text_field

		json.profile @user_stuff.profile_thumb_url

		json.file @user_stuff.resume_thumb_url

		json.student_basic_info_per @user_stuff.user_meter.student_basic_info_per.to_i
      	json.student_education_per @user_stuff.user_meter.student_education_per.to_i
      	json.student_achievement_per @user_stuff.user_meter.student_achievement_per.to_i
      	json.student_extra_curri_per @user_stuff.user_meter.student_extra_curri_per.to_i
      	json.user_total_per @user_stuff.user_meter.total_per.to_i

      	json.created_at @user_stuff.created_at.to_i
		json.updated_at @user_stuff.updated_at.to_i      	

      	json.student_educations @user_stuff.student_educations do |education|
		json.extract! education, :id, :user_id, :standard, :school, :year		
		json.edu_created_at education.created_at.to_i
		json.edu_updated_at education.updated_at.to_i
		end

		json.student_awards @user_stuff.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description
		json.file award.thumb_url		
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
		end

		json.student_certificates @user_stuff.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year
		json.file certificate.thumb_url
		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
		end

		json.student_curriculars @user_stuff.user_curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date
		json.file curricular.thumb_url
		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
		end

		

	elsif @user_stuff.role == 'Faculty'
		json.User @user_stuff, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :faculty_work_with_type, :faculty_uni_name, :faculty_subject, :faculty_designation, :faculty_join_from, :file_type, :text_field

		json.profile @user_stuff.profile_thumb_url

		json.file @user_stuff.resume_thumb_url

		json.faculty_basic_info_per @user_stuff.user_meter.faculty_basic_info_per.to_i
      	json.faculty_experience_per @user_stuff.user_meter.faculty_experience_per.to_i
      	json.faculty_achievement_per @user_stuff.user_meter.faculty_achievement_per.to_i
      	json.user_total_per @user_stuff.user_meter.total_per.to_i


		json.created_at @user_stuff.created_at.to_i
		json.updated_at @user_stuff.updated_at.to_i

		json.faculty_awards @user_stuff.user_awards do |award|
		json.extract! award, :id, :user_id, :name, :description
		json.file award.thumb_url		
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
		end

		json.faculty_certificates @user_stuff.user_certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year
		json.file certificate.thumb_url
		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
		end
		
	end
end
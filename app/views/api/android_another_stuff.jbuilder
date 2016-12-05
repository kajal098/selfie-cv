json.status "Success"

if @user_stuff

	if @user_stuff.role == 'Jobseeker'

		json.User @user_stuff, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type, :active

		json.country_name @user_stuff.stock_country ? @user_stuff.stock_country.name : ""

		json.profile_thumb @user_stuff.profile_thumb_url
		json.profile @user_stuff.profile_pic.url
		json.resume_thumb @user_stuff.resume_thumb_url
		json.resume @user_stuff.file.url
		json.back_profile_thumb @user_stuff.back_profile_thumb_url
		json.back_profile @user_stuff.back_profile.url

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
			json.extract! experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company, :file_type
			json.file_thumb experience.thumb_url
			json.file experience.file.url
			json.experience_created_at experience.created_at.to_i
			json.experience_updated_at experience.updated_at.to_i
		end

		json.jobseeker_preferred_works @user_stuff.user_preferred_works do |user_preferred_work|
			json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type
			json.created_at user_preferred_work.created_at.to_i
			json.updated_at user_preferred_work.updated_at.to_i
		end

		json.jobseeker_awards @user_stuff.user_awards do |award|
			json.extract! award, :id, :user_id, :name, :description, :file_type
			json.file_thumb award.thumb_url		
			json.file award.file.url
			json.award_created_at award.created_at.to_i
			json.award_updated_at award.updated_at.to_i
		end

		json.jobseeker_certificates @user_stuff.user_certificates do |certificate|
			json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :file_type
			json.file_thumb certificate.thumb_url
			json.file certificate.file.url
			json.certificate_created_at certificate.created_at.to_i
			json.certificate_updated_at certificate.updated_at.to_i
		end

		json.jobseeker_curriculars @user_stuff.user_curriculars do |curricular|
			json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :file_type
			json.file_thumb curricular.thumb_url
			json.file curricular.file.url
			json.curricular_created_at curricular.created_at.to_i
			json.curricular_updated_at curricular.updated_at.to_i
		end

		json.jobseeker_future_goals @user_stuff.user_future_goals do |future_goal|
			json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type, :file_type
			json.file_thumb future_goal.thumb_url
			json.file future_goal.file.url
			json.future_goal_created_at future_goal.created_at.to_i
			json.future_goal_updated_at future_goal.updated_at.to_i
		end

		json.jobseeker_environments @user_stuff.user_environments do |environment|
			json.extract! environment, :id, :user_id, :env_type, :title, :file_type
			json.file_thumb environment.thumb_url
			json.file environment.file.url
			json.environment_created_at environment.created_at.to_i
			json.environment_updated_at environment.updated_at.to_i
		end

		json.jobseeker_references @user_stuff.user_references do |ref|
			json.extract! ref, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location, :file_type
			json.file_thumb ref.thumb_url
			json.file ref.file.url
			json.ref_created_at ref.created_at.to_i
			json.ref_updated_at ref.updated_at.to_i
		end

		json.likes @user_stuff.likes.count
		json.views @user_stuff.views.count
		json.shares @user_stuff.shares.count
		json.favourites @user_stuff.favourites.count
		json.rates @user_stuff.rates.count

		if ( current_user.user_likes.where(like_id: @user_stuff.id).count > 0 )
			json.liked true
		else
			json.liked false
		end

		if ( current_user.user_favourites.where(favourite_id: @user_stuff.id).count > 0 )
			json.favourited true
		else
			json.favourited false
		end

		if ( current_user.user_rates.where(rate_id: @user_stuff.id).count > 0 )
			json.rate_type current_user.user_rates.where(rate_id: @user_stuff.id).last.rate_type
		else
			json.rate_type ""
		end

	elsif @user_stuff.role == 'Company'

		json.User @user_stuff, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :country_id,  :company_contact, :company_skype_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :file_type, :company_logo_type, :company_profile_type, :company_brochure_type, :active

		json.country_name @user_stuff.stock_country ? @user_stuff.stock_country.name : ""

		json.logo @user_stuff.logo_thumb_url
		json.logo_thumb @user_stuff.logo_thumb_url
		json.logo @user_stuff.company_logo.url		
		json.profile_thumb @user_stuff.company_profile_thumb_url
		json.profile @user_stuff.company_profile.url
		json.brochure_thumb @user_stuff.brochure_thumb_url
		json.brochure @user_stuff.company_brochure.url
		json.back_profile_thumb @user_stuff.back_profile_thumb_url
		json.back_profile @user_stuff.back_profile.url

		json.company_id @user_stuff.company ? @user_stuff.company_id : ""
		json.company @user_stuff.company ? @user_stuff.company.name : ""
		json.industry_id @user_stuff.industry ? @user_stuff.industry_id : ""
		json.industry @user_stuff.industry ? @user_stuff.industry.name : ""
		json.created_at @user_stuff.created_at.to_i
		json.updated_at @user_stuff.updated_at.to_i
		
		json.company_awards @user_stuff.user_awards do |award|
			json.extract! award, :id, :user_id, :name, :description, :file_type
			json.file_thumb award.thumb_url	
			json.file award.file.url	
			json.award_created_at award.created_at.to_i
			json.award_updated_at award.updated_at.to_i
		end

		json.company_certificates @user_stuff.user_certificates do |certificate|
			json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :file_type
			json.file_thumb certificate.thumb_url
			json.file certificate.file.url
			json.certificate_created_at certificate.created_at.to_i
			json.certificate_updated_at certificate.updated_at.to_i
		end

		json.company_environments @user_stuff.user_environments do |environment|
			json.extract! environment, :id, :user_id, :env_type, :title
			json.file_thumb environment.thumb_url
			json.file environment.file.url
			json.environment_created_at environment.created_at.to_i
			json.environment_updated_at environment.updated_at.to_i
		end

		json.company_galeries @user_stuff.company_galeries do |galery|
			json.extract! galery, :id
			json.FileThumb galery.thumb_url
			json.File galery.file.url
			json.galery_created_at galery.created_at.to_i
			json.galery_updated_at galery.updated_at.to_i
		end

		json.likes @user_stuff.likes.count
		json.views @user_stuff.views.count
		json.shares @user_stuff.shares.count
		json.favourites @user_stuff.favourites.count
		json.rates @user_stuff.rates.count

		if ( current_user.user_likes.where(like_id: @user_stuff.id).count > 0 )
			json.liked true
		else
			json.liked false
		end

		if ( current_user.user_favourites.where(favourite_id: @user_stuff.id).count > 0 )
			json.favourited true
		else
			json.favourited false
		end

		if ( current_user.user_rates.where(rate_id: @user_stuff.id).count > 0 )
			json.rate_type current_user.user_rates.where(rate_id: @user_stuff.id).last.rate_type
		else
			json.rate_type ""
		end

	elsif @user_stuff.role == 'Student'

		json.User @user_stuff, :id, :username, :email, :role, :first_name, :last_name, :middle_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :file_type, :active

		json.country_name @user_stuff.stock_country ? @user_stuff.stock_country.name : ""

		json.profile_thumb @user_stuff.profile_thumb_url
		json.profile @user_stuff.profile_pic.url
		json.file_thumb @user_stuff.resume_thumb_url
		json.file @user_stuff.file.url
		json.back_profile_thumb @user_stuff.back_profile_thumb_url
		json.back_profile @user_stuff.back_profile.url

		json.student_educations @user_stuff.student_educations do |education|
			json.extract! education, :id, :user_id, :standard, :school, :year		
			json.edu_created_at education.created_at.to_i
			json.edu_updated_at education.updated_at.to_i
		end

		json.student_awards @user_stuff.user_awards do |award|
			json.extract! award, :id, :user_id, :name, :description, :file_type
			json.file_thumb award.thumb_url		
			json.file award.file.url
			json.award_created_at award.created_at.to_i
			json.award_updated_at award.updated_at.to_i
		end

		json.student_certificates @user_stuff.user_certificates do |certificate|
			json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :file_type
			json.file_thumb certificate.thumb_url
			json.file certificate.file.url
			json.certificate_created_at certificate.created_at.to_i
			json.certificate_updated_at certificate.updated_at.to_i
		end

		json.student_curriculars @user_stuff.user_curriculars do |curricular|
			json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :file_type
			json.file_thumb curricular.thumb_url
			json.file curricular.file.url
			json.curricular_created_at curricular.created_at.to_i
			json.curricular_updated_at curricular.updated_at.to_i
		end

		json.student_future_goals @user_stuff.user_future_goals do |future_goal|
			json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type, :file_type
			json.file_thumb future_goal.thumb_url
			json.file future_goal.file.url
			json.future_goal_created_at future_goal.created_at.to_i
			json.future_goal_updated_at future_goal.updated_at.to_i
		end


		json.student_marksheets @user_stuff.user_marksheets do |marksheet|
			json.extract! marksheet, :id, :school_name, :standard, :grade, :year, :file_type
			json.file_thumb marksheet.thumb_url
			json.file marksheet.file.url
			json.marksheet_created_at marksheet.created_at.to_i
			json.marksheet_updated_at marksheet.updated_at.to_i
		end

		json.student_projects @user_stuff.user_projects do |project|
			json.extract! project, :id, :title, :description, :file_type
			json.file_thumb project.thumb_url
			json.file project.file.url
			json.project_created_at project.created_at.to_i
			json.project_updated_at project.updated_at.to_i
		end

		json.likes @user_stuff.likes.count
		json.views @user_stuff.views.count
		json.shares @user_stuff.shares.count
		json.favourites @user_stuff.favourites.count
		json.rates @user_stuff.rates.count

		if ( current_user.user_likes.where(like_id: @user_stuff.id).count > 0 )
			json.liked true
		else
			json.liked false
		end

		if ( current_user.user_favourites.where(favourite_id: @user_stuff.id).count > 0 )
			json.favourited true
		else
			json.favourited false
		end

		if ( current_user.user_rates.where(rate_id: @user_stuff.id).count > 0 )
			json.rate_type current_user.user_rates.where(rate_id: @user_stuff.id).last.rate_type
		else
			json.rate_type ""
		end

	elsif @user_stuff.role == 'Faculty'

		json.User @user_stuff, :id, :username, :email, :role, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :country_id, :contact_number, :faculty_work_with_type, :faculty_uni_name, :faculty_subject, :faculty_designation, :faculty_join_from, :file_type, :active

		json.country_name @user_stuff.stock_country ? @user_stuff.stock_country.name : ""

		json.profile_thumb @user_stuff.profile_thumb_url
		json.profile @user_stuff.profile_pic.url
		json.resume_thumb @user_stuff.resume_thumb_url
		json.resume @user_stuff.file.url
		json.back_profile_thumb @user_stuff.back_profile_thumb_url
		json.back_profile @user_stuff.back_profile.url

		json.faculty_awards @user_stuff.user_awards do |award|
			json.extract! award, :id, :user_id, :name, :description, :file_type
			json.file_thumb award.thumb_url		
			json.file award.file.url
			json.award_created_at award.created_at.to_i
			json.award_updated_at award.updated_at.to_i
		end

		json.faculty_certificates @user_stuff.user_certificates do |certificate|
			json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :file_type
			json.file_thumb certificate.thumb_url
			json.file certificate.file.url
			json.certificate_created_at certificate.created_at.to_i
			json.certificate_updated_at certificate.updated_at.to_i
		end

		json.faculty_affiliations @user_stuff.faculty_affiliations do |affiliation|
			json.extract! affiliation, :id, :user_id, :university,:collage_name,:subject,:designation,:join_from, :join_till, :file_type
			json.file_thumb affiliation.thumb_url
			json.file affiliation.file.url
			json.affiliation_created_at affiliation.created_at.to_i
			json.affiliation_updated_at affiliation.updated_at.to_i
		end

		json.faculty_workshops @user_stuff.faculty_workshops do |workshop|
			json.extract! workshop, :id, :user_id, :title, :description, :file_type
			json.file_thumb workshop.thumb_url
			json.file workshop.file.url
			json.workshop_created_at workshop.created_at.to_i
			json.workshop_updated_at workshop.updated_at.to_i
		end

		json.faculty_publications @user_stuff.faculty_publications do |publication|
			json.extract! publication, :id, :user_id, :title, :description, :file_type
			json.file_thumb publication.thumb_url
			json.file publication.file.url
			json.publication_created_at publication.created_at.to_i
			json.publication_updated_at publication.updated_at.to_i
		end

		json.faculty_researches @user_stuff.faculty_researches do |research|
			json.extract! research, :id, :user_id, :title, :description, :file_type
			json.file_thumb research.thumb_url
			json.file research.file.url
			json.research_created_at research.created_at.to_i
			json.research_updated_at research.updated_at.to_i
		end

		json.likes @user_stuff.likes.count
		json.views @user_stuff.views.count
		json.shares @user_stuff.shares.count
		json.favourites @user_stuff.favourites.count
		json.rates @user_stuff.rates.count

		if ( current_user.user_likes.where(like_id: @user_stuff.id).count > 0 )
			json.liked true
		else
			json.liked false
		end

		if ( current_user.user_favourites.where(favourite_id: @user_stuff.id).count > 0 )
			json.favourited true
		else
			json.favourited false
		end

		if ( current_user.user_rates.where(rate_id: @user_stuff.id).count > 0 )
			json.rate_type current_user.user_rates.where(rate_id: @user_stuff.id).last.rate_type
		else
			json.rate_type ""
		end

	end
	
end
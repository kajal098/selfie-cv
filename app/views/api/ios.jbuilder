if @update_image
	json.profile_thumb @update_image.profile_thumb_url
	json.profile @update_image.profile_photo_url
end

if @user
	if @user.role == 'Jobseeker'
		json.User @user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :file_type, :text_field

		json.profile_thumb @user.profile_thumb_url
		json.profile @user.profile_pic.url

		json.resume_thumb @user.resume_thumb_url
		json.resume @user.file.url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

json.resume_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.resume_per.to_i, "resume") : 0

json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0

json.curri_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.curri_per.to_i, "extra") : 0

json.future_goal_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.future_goal_per.to_i, "futuregoal") : 0

json.working_env_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.working_env_per.to_i, "workingenv") : 0

json.ref_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.ref_per.to_i, "references") : 0

json.whizquiz_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.whizquiz_per.to_i, "whizquiz") : 0

json.total_per @user.user_meter ? @user.user_meter.profile_meter_per.to_i : 0

		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count
		
	elsif @user.role == 'Company'
		json.User @user, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country,  :company_contact, :company_skype_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :file_type, :text_field, :company_logo_type, :company_profile_type, :company_brochure_type
      

		json.logo_thumb @user.logo_thumb_url
		json.logo @user.company_logo.url		

		json.profile_thumb @user.company_profile_thumb_url
		json.profile @user.company_profile.url

		json.brochure_thumb @user.brochure_thumb_url
		json.brochure @user.company_brochure.url

		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.company_id @user.company ? @user.company_id : ""
		json.company @user.company ? @user.company.name : ""

		json.industry_id @user.industry ? @user.industry_id : ""
		json.industry @user.industry ? @user.industry.name : ""
		

json.company_info_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.company_info_per.to_i, "info") : 0

json.corporate_identity_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.corporate_identity_per.to_i, "corporate") : 0

json.growth_and_goal_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.growth_and_goal_per.to_i, "growth") : 0

json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0

json.galery_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.galery_per.to_i, "gallery") : 0

json.working_env_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.working_env_per.to_i, "workingenv") : 0

json.total_per @user.user_meter ? @user.user_meter.total_per.to_i : 0


		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count

	elsif @user.role == 'Student'
		json.User @user, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :file_type, :text_field

		json.profile_thumb @user.profile_thumb_url
		json.profile @user.profile_pic.url

		json.resume_thumb @user.resume_thumb_url
		json.resume @user.file.url

json.student_basic_info_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.student_basic_info_per.to_i, "info") : 0

json.student_education_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.student_education_per.to_i, "education") : 0

json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0

json.curri_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.curri_per.to_i, "extra") : 0

json.future_goal_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.future_goal_per.to_i, "futuregoal") : 0

json.total_per @user.user_meter ?  @user.user_meter.total_per.to_i : 0
      
		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count

	elsif @user.role == 'Faculty'
		json.User @user, :id, :username, :email, :role, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :faculty_work_with_type, :faculty_uni_name, :faculty_subject, :faculty_designation, :faculty_join_from, :file_type, :text_field

		json.profile_thumb @user.profile_thumb_url
		json.profile @user.profile_pic.url

		json.resume_thumb @user.resume_thumb_url
		json.resume @user.file.url

json.faculty_basic_info_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.faculty_basic_info_per.to_i, "info") : 0

json.experience_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.experience_per.to_i, "experience") : 0

json.achievement_per @user.user_meter ? @user.cal_preview_per(@user.user_meter.achievement_per.to_i, "achievement") : 0

json.total_per @user.user_meter ?  @user.user_meter.total_per.to_i : 0


		json.created_at @user.created_at.to_i
		json.updated_at @user.updated_at.to_i

		json.likes @user.likes.count
		json.views @user.views.count
		json.shares @user.shares.count
		json.favourites @user.favourites.count
		json.rates @user.rates.count
		
	end
end

if @company
	
		json.User @company, :id, :username, :role, :company_name, :company_establish_from, :company_functional_area, :company_address, :company_zipcode, :company_city, :company_country, :company_contact, :company_skype_id, :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :file_type, :text_field, :company_logo_type, :company_profile_type, :company_brochure_type

		json.logo_thumb @company.logo_thumb_url
		json.logo @company.company_logo.url		

		json.profile_thumb @company.company_profile_thumb_url
		json.profile @company.company_profile.url

		json.brochure_thumb @company.brochure_thumb_url
		json.brochure @company.company_brochure.url

		json.company_id @company.company ? @company.company_id : ""
		json.company @company.company ? @company.company.name : ""

		json.industry_id @company.industry ? @company.industry_id : ""
		json.industry @company.industry ? @company.industry.name : ""

		json.created_at @company.created_at.to_i
		json.updated_at @company.updated_at.to_i

json.company_info_per @company.user_meter ? @company.cal_preview_per(@company.user_meter.company_info_per.to_i, "info") : 0

json.corporate_identity_per @company.user_meter ? @company.cal_preview_per(@company.user_meter.corporate_identity_per.to_i, "corporate") : 0

json.growth_and_goal_per @company.user_meter ? @company.cal_preview_per(@company.user_meter.growth_and_goal_per.to_i, "growth") : 0

json.achievement_per @company.user_meter ? @company.cal_preview_per(@company.user_meter.achievement_per.to_i, "achievement") : 0

json.galery_per @company.user_meter ? @company.cal_preview_per(@company.user_meter.galery_per.to_i, "gallery") : 0

json.working_env_per @company.user_meter ? @company.cal_preview_per(@company.user_meter.working_env_per.to_i, "workingenv") : 0

json.total_per @company.user_meter ? @company.user_meter.total_per.to_i : 0


		json.likes @company.likes.count
		json.views @company.views.count
		json.shares @company.shares.count
		json.favourites @company.favourites.count
		json.rates @company.rates.count
		
	
end


if @users
@all_users = @users.order('created_at DESC')
		json.users @all_users do |user|
				if user.role == "Jobseeker"
						json.extract! user, :id, :username, :email, :role, :title, :first_name, :middle_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number, :file_type, :text_field

						json.profile_thumb user.profile_thumb_url
						json.profile user.profile_pic.url

						json.profile_video user.profile_photo_url
						json.resume_thumb user.resume_thumb_url

						json.resume user.file.url
						json.created_at user.created_at.to_i
						json.updated_at user.updated_at.to_i
						json.skills !user.user_educations.empty? ? user.user_educations.map(&:skill).join(",") : ""


json.resume_per user.user_meter ? user.cal_preview_per(user.user_meter.resume_per.to_i, "resume") : 0

json.achievement_per user.user_meter ? user.cal_preview_per(user.user_meter.achievement_per.to_i, "achievement") : 0

json.curri_per user.user_meter ? user.cal_preview_per(user.user_meter.curri_per.to_i, "extra") : 0

json.future_goal_per user.user_meter ? user.cal_preview_per(user.user_meter.future_goal_per.to_i, "futuregoal") : 0

json.working_env_per user.user_meter ? user.cal_preview_per(user.user_meter.working_env_per.to_i, "workingenv") : 0

json.ref_per user.user_meter ? user.cal_preview_per(user.user_meter.ref_per.to_i, "references") : 0

json.whizquiz_per user.user_meter ? user.cal_preview_per(user.user_meter.whizquiz_per.to_i, "whizquiz") : 0

json.total_per user.user_meter ? user.user_meter.total_per.to_i : 0


					json.likes user.likes.count
					json.views user.views.count
					json.shares user.shares.count
					json.favourites user.favourites.count
					json.rates user.rates.count

				elsif user.role == "Company"
						json.extract! user, :id, :username, :role, :company_name, :company_establish_from,  :company_functional_area, :company_address, :company_zipcode, :company_city, :company_contact, :company_skype_id,  :company_website, :company_facebook_link, :company_turnover, :company_no_of_emp, :company_growth_ratio, :company_new_ventures, :company_future_turnover, :company_future_new_venture_location, :company_future_outlet, :file_type, :text_field, :company_logo_type, :company_profile_type, :company_brochure_type

						json.logo_thumb user.logo_thumb_url
						json.logo user.company_logo.url

						json.profile_thumb user.company_profile_thumb_url
						json.profile user.company_profile.url

						json.brochure_thumb user.brochure_thumb_url
						json.brochure user.company_brochure.url

						json.created_at user.created_at.to_i
						json.updated_at user.updated_at.to_i

						json.company_id user.company ? user.company_id : ""
						json.company user.company ? user.company.name : ""

						json.industry_id user.industry ? user.industry_id : ""
						json.industry user.industry ? user.industry.name : ""

json.company_info_per user.user_meter ? user.cal_preview_per(user.user_meter.company_info_per.to_i, "info") : 0

json.corporate_identity_per user.user_meter ? user.cal_preview_per(user.user_meter.corporate_identity_per.to_i, "corporate") : 0

json.growth_and_goal_per user.user_meter ? user.cal_preview_per(user.user_meter.growth_and_goal_per.to_i, "growth") : 0

json.achievement_per user.user_meter ? user.cal_preview_per(user.user_meter.achievement_per.to_i, "achievement") : 0

json.galery_per user.user_meter ? user.cal_preview_per(user.user_meter.galery_per.to_i, "gallery") : 0

json.working_env_per user.user_meter ? user.cal_preview_per(user.user_meter.working_env_per.to_i, "workingenv") : 0

json.total_per user.user_meter ? user.user_meter.total_per.to_i : 0


						

						json.likes user.likes.count
						json.views user.views.count
						json.shares user.shares.count
						json.favourites user.favourites.count
						json.rates user.rates.count

				end
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
		json.extract! experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company, :text_field, :file_type

		json.file_thumb experience.thumb_url
		json.file experience.file.url

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
		json.extract! award, :id, :user_id, :name, :description, :text_field, :file_type

		json.file_thumb award.thumb_url
		json.file award.file.url
		
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
	end
end

if @certificate
@certificates = @user.user_certificates.order('created_at DESC')
	json.certificates @certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :text_field, :file_type

		json.file_thumb certificate.thumb_url
		json.file certificate.file.url

		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
	end
end


if @curricular
@curriculars = @user.user_curriculars.order('created_at DESC')
	json.curriculars @curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :text_field, :file_type

		json.file_thumb curricular.thumb_url
		json.file curricular.file.url

		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
	end
end

if @future_goal
@future_goals = @user.user_future_goals.order('created_at DESC')
	json.future_goals @future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type, :text_field, :file_type

		json.file_thumb future_goal.thumb_url
		json.file future_goal.file.url

		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
	end
end

if @environment
@environments = @user.user_environments.order('created_at DESC')
	json.environments @environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title, :text_field, :file_type, :text_field

		json.file_thumb environment.thumb_url
		json.file environment.file.url

		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
	end
end


if @reference
@references = @user.user_references.order('created_at DESC')
	json.references @references do |env|
		json.extract! env, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location, :text_field, :file_type

		json.file_thumb env.thumb_url
		json.file env.file.url

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

if @companystocks
@all_companystocks = @companystocks.order('created_at DESC')
	json.companystocks @all_companystocks do |coun|
		json.id coun.id
		json.country coun.sensex_co

		json.created_at coun.created_at.to_i
		json.updated_at coun.updated_at.to_i
	end
end

if @user_educations
@educations = @user.user_educations.order('created_at DESC')
	json.user_educations @educations do |education|
	json.extract! education, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
	json.course education.course.name
	json.specialization education.specialization.name

	json.edu_created_at education.created_at.to_i
	json.edu_updated_at education.updated_at.to_i
end
end

if @user_experiences
@experiences = @user.user_experiences.order('created_at DESC')
	json.user_experiences @experiences do |experience|
	json.extract! experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company, :text_field, :file_type

	json.exp_created_at experience.created_at.to_i
	json.exp_updated_at experience.updated_at.to_i
end
end

if @user_preferred_works
@preferred_works = @user.user_preferred_works.order('created_at DESC')
	json.user_preferred_works @preferred_works do |user_preferred_work|
		json.extract! user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type

		json.created_at user_preferred_work.created_at.to_i
		json.updated_at user_preferred_work.updated_at.to_i
	end
end

if @user_awards
@awards = @user.user_awards.order('created_at DESC')
	json.awards @awards do |award|
		json.extract! award, :id, :user_id, :name, :description, :text_field, :file_type
		json.file_thumb award.thumb_url
		json.file award.file.url
		json.award_created_at award.created_at.to_i
		json.award_updated_at award.updated_at.to_i
	end
end

if @user_certificates
@certificates = @user.user_certificates.order('created_at DESC')
	json.certificates @certificates do |certificate|
		json.extract! certificate, :id, :user_id, :certificate_type, :name, :year, :text_field, :file_type

		json.file_thumb certificate.thumb_url
		json.file certificate.file.url

		json.certificate_created_at certificate.created_at.to_i
		json.certificate_updated_at certificate.updated_at.to_i
	end
end


if @user_curriculars
@curriculars = @user.user_curriculars.order('created_at DESC')
	json.user_curriculars @curriculars do |curricular|
		json.extract! curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :text_field, :file_type

		json.file_thumb curricular.thumb_url
		json.file curricular.file.url

		json.curricular_created_at curricular.created_at.to_i
		json.curricular_updated_at curricular.updated_at.to_i
	end
end

if @user_future_goals
@future_goals = @user.user_future_goals.order('created_at DESC')
	json.user_future_goals @future_goals do |future_goal|
		json.extract! future_goal, :id, :user_id, :goal_type, :title, :term_type, :text_field, :file_type

		json.file_thumb future_goal.thumb_url
		json.file future_goal.file.url

		json.future_goal_created_at future_goal.created_at.to_i
		json.future_goal_updated_at future_goal.updated_at.to_i
	end
end

if @user_working_environments
@environments = @user.user_environments.order('created_at DESC')
	json.user_working_environments @environments do |environment|
		json.extract! environment, :id, :user_id, :env_type, :title, :text_field, :file_type, :text_field

		json.file_thumb environment.thumb_url
		json.file environment.file.url

		json.environment_created_at environment.created_at.to_i
		json.environment_updated_at environment.updated_at.to_i
	end
end


if @user_references
@references = @user.user_references.order('created_at DESC')
	json.user_references @references do |env|
		json.extract! env, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location, :text_field, :file_type

		json.file_thumb env.thumb_url
		json.file env.file.url

		json.env_created_at env.created_at.to_i
		json.env_updated_at env.updated_at.to_i
	end
end

if @update_user_education
	json.extract! @update_user_education, :id, :user_id, :year, :school, :skill, :course_id, :specialization_id
	json.course @update_user_education.course.name
	json.specialization @update_user_education.specialization.name

	json.created_at @update_user_education.created_at.to_i
	json.updated_at @update_user_education.updated_at.to_i
end

if @update_user_experience
	json.extract! @update_user_experience, :id, :user_id, :name,:exp_type, :start_from, :description, :working_till, :designation, :current_company, :text_field, :file_type

	json.file_thumb @update_user_experience.thumb_url
	json.file @update_user_experience.file.url

	json.created_at @update_user_experience.created_at.to_i
	json.updated_at @update_user_experience.updated_at.to_i
end

if @update_user_preferred_work
	json.extract! @update_user_preferred_work, :id, :user_id, :ind_name, :functional_name, :preferred_designation, :preferred_location, :current_salary, :expected_salary, :time_type

		json.created_at @update_user_preferred_work.created_at.to_i
		json.updated_at @update_user_preferred_work.updated_at.to_i
end

if @update_user_award
	json.extract! @update_user_award, :id, :user_id, :name, :description, :text_field, :file_type
		json.created_at @update_user_award.created_at.to_i
		json.updated_at @update_user_award.updated_at.to_i
end

if @update_user_certificate
	json.extract! @update_user_certificate, :id, :user_id, :certificate_type, :name, :year, :text_field, :file_type

		json.file_thumb @update_user_certificate.thumb_url
		json.file @update_user_certificate.file.url

		json.created_at @update_user_certificate.created_at.to_i
		json.updated_at @update_user_certificate.updated_at.to_i
end

if @update_user_curricular
	json.extract! @update_user_curricular, :id, :user_id, :curricular_type, :title, :team_type, :location, :date, :text_field, :file_type

		json.file_thumb @update_user_curricular.thumb_url
		json.file @update_user_curricular.file.url

		json.created_at @update_user_curricular.created_at.to_i
		json.updated_at @update_user_curricular.updated_at.to_i
end

if @update_user_future_goal
	json.extract! @update_user_future_goal, :id, :user_id, :goal_type, :title, :term_type, :text_field, :file_type

		json.file_thumb @update_user_future_goal.thumb_url
		json.file @update_user_future_goal.file.url

		json.created_at @update_user_future_goal.created_at.to_i
		json.updated_at @update_user_future_goal.updated_at.to_i
end

if @update_user_environment
	json.extract! @update_user_environment, :id, :user_id, :env_type, :title, :text_field, :file_type, :text_field

		json.file_thumb @update_user_environment.thumb_url
		json.file @update_user_environment.file.url

		json.created_at @update_user_environment.created_at.to_i
		json.updated_at @update_user_environment.updated_at.to_i
end


if @update_user_reference
	json.extract! @update_user_reference, :id, :user_id, :title, :ref_type, :from, :email, :contact, :date, :location, :text_field, :file_type

		json.file_thumb @update_user_reference.thumb_url
		json.file @update_user_reference.file.url

		json.created_at @update_user_reference.created_at.to_i
		json.updated_at @update_user_reference.updated_at.to_i
end

if @basic_info
json.BasicInfoOfStudent @basic_info, :id, :username, :email, :role, :first_name, :last_name, :gender, :date_of_birth, :nationality, :address, :city, :zipcode, :contact_number

		json.file_thumb @basic_info.resume_thumb_url
		json.file @basic_info.file.url

json.student_basic_info_per @basic_info.user_meter ? @basic_info.cal_preview_per(@basic_info.user_meter.student_basic_info_per.to_i, "info") : 0
json.student_education_per @basic_info.user_meter ? @basic_info.cal_preview_per(@basic_info.user_meter.student_education_per.to_i, "education") : 0
json.achievement_per @basic_info.user_meter ? @basic_info.cal_preview_per(@basic_info.user_meter.achievement_per.to_i, "achievement") : 0
json.curri_per @basic_info.user_meter ? @basic_info.cal_preview_per(@basic_info.user_meter.curri_per.to_i, "extra") : 0
json.future_goal_per @basic_info.user_meter ? @basic_info.cal_preview_per(@basic_info.user_meter.future_goal_per.to_i, "futuregoal") : 0
json.total_per @basic_info.user_meter ? @basic_info.user_meter.total_per.to_i : 0


		json.created_at @basic_info.created_at.to_i
		json.updated_at @basic_info.updated_at.to_i
end

if @student_education
	@educations = @user.student_educations.order('created_at DESC')
	json.student_educations @educations do |education|
		json.extract! education, :id, :user_id, :standard, :school, :year
		
		json.edu_created_at education.created_at.to_i
		json.edu_updated_at education.updated_at.to_i
	end
end

if @update_student_education
	json.extract! @update_student_education, :id, :user_id, :standard, :school, :year
	
	json.edu_created_at @update_student_education.created_at.to_i
	json.edu_updated_at @update_student_education.updated_at.to_i
end

if @student_educations
@educations = @user.student_educations.order('created_at DESC')
	json.student_educations @educations do |education|
	json.extract! education, :id, :user_id, :standard, :school, :year

	json.edu_created_at education.created_at.to_i
	json.edu_updated_at education.updated_at.to_i
end
end

if @student_marksheet
	@marksheets = @user.user_marksheets.order('created_at DESC')
	json.student_marksheets @marksheets do |marksheet|
		json.extract! marksheet, :id, :user_id, :school_name, :standard, :grade, :year	, :file_type

		json.file_thumb marksheet.thumb_url
		json.file marksheet.file.url
	
		json.marksheet_created_at marksheet.created_at.to_i
		json.marksheet_updated_at marksheet.updated_at.to_i
	end
end

if @update_student_marksheet
	json.extract! @update_student_marksheet, :id, :user_id, :school_name, :standard, :grade, :year	, :file_type

	json.file_thumb @update_student_marksheet.thumb_url
	json.file @update_student_marksheet.file.url

	json.marksheet_created_at @update_student_marksheet.created_at.to_i
	json.marksheet_updated_at @update_student_marksheet.updated_at.to_i
end

if @student_marksheets
@marksheets = @user.user_marksheets.order('created_at DESC')
	json.student_marksheets @marksheets do |marksheet|
	json.extract! marksheet, :id, :user_id, :school_name, :standard, :grade, :year	, :file_type

	json.file_thumb marksheet.thumb_url
	json.file marksheet.file.url	

	json.marksheet_created_at marksheet.created_at.to_i
	json.marksheet_updated_at marksheet.updated_at.to_i
end
end

if @student_project
	@projects = @user.user_projects.order('created_at DESC')
	json.student_projects @projects do |project|
		json.extract! project, :id, :user_id, :title, :description
		

		json.project_created_at project.created_at.to_i
		json.project_updated_at project.updated_at.to_i
	end
end

if @update_student_project
	json.extract! @update_student_project, :id, :user_id, :title, :description

	json.project_created_at @update_student_project.created_at.to_i
	json.project_updated_at @update_student_project.updated_at.to_i
end

if @student_projects
@projects = @user.user_projects.order('created_at DESC')
	json.student_projects @projects do |project|
	json.extract! project, :id, :user_id, :title, :description

	json.project_created_at project.created_at.to_i
	json.project_updated_at project.updated_at.to_i
end
end

if @faculty_affiliation
	@affiliations = @user.faculty_affiliations.order('created_at DESC')
	json.faculty_affiliations @affiliations do |affiliation|
		json.extract! affiliation, :id, :user_id, :university,:collage_name,:subject,:designation,:join_from, :join_till
		

		json.affiliation_created_at affiliation.created_at.to_i
		json.affiliation_updated_at affiliation.updated_at.to_i
	end
end

if @update_faculty_affiliation
	json.extract! @update_faculty_affiliation, :id, :user_id, :university,:collage_name,:subject,:designation,:join_from, :join_till

	json.affiliation_created_at @update_faculty_affiliation.created_at.to_i
	json.affiliation_updated_at @update_faculty_affiliation.updated_at.to_i
end

if @faculty_affiliations
	@affiliations = @user.faculty_affiliations.order('created_at DESC')
	json.faculty_affiliations @affiliations do |affiliation|
	json.extract! affiliation, :id, :user_id, :university,:collage_name,:subject,:designation,:join_from, :join_till


	json.affiliation_created_at affiliation.created_at.to_i
	json.affiliation_updated_at affiliation.updated_at.to_i
	end
end

if @faculty_workshop
	@workshops = @user.faculty_workshops.order('created_at DESC')
	json.faculty_workshops @workshops do |workshop|
		json.extract! workshop, :id, :user_id, :description
		

		json.workshop_created_at workshop.created_at.to_i
		json.workshop_updated_at workshop.updated_at.to_i
	end
end

if @update_faculty_workshop
	json.extract! @update_faculty_workshop, :id, :user_id, :description

	json.workshop_created_at @update_faculty_workshop.created_at.to_i
	json.workshop_updated_at @update_faculty_workshop.updated_at.to_i
end

if @faculty_workshops
	@workshops = @user.faculty_workshops.order('created_at DESC')
	json.faculty_workshops @workshops do |workshop|
	json.extract! workshop, :id, :user_id, :description

	json.workshop_created_at workshop.created_at.to_i
	json.workshop_updated_at workshop.updated_at.to_i
	end
end

if @faculty_publication
	@publications = @user.faculty_publications.order('created_at DESC')
	json.faculty_publications @publications do |publication|
		json.extract! publication, :id, :user_id, :title, :description, :file_type
		
		json.file_thumb publication.thumb_url
		json.file publication.file.url

		json.publication_created_at publication.created_at.to_i
		json.publication_updated_at publication.updated_at.to_i
	end
end

if @update_faculty_publication
	json.extract! @update_faculty_publication, :id, :user_id, :title, :description, :file_type

	json.file_thumb @update_faculty_publication.thumb_url
	json.file @update_faculty_publication.file.url

	json.publication_created_at @update_faculty_publication.created_at.to_i
	json.publication_updated_at @update_faculty_publication.updated_at.to_i
end

if @faculty_publications
	@publications = @user.faculty_publications.order('created_at DESC')
	json.faculty_publications @publications do |publication|
	json.extract! publication, :id, :user_id, :title, :description, :file_type

	json.file_thumb publication.thumb_url
	json.file publication.file.url

	json.publication_created_at publication.created_at.to_i
	json.publication_updated_at publication.updated_at.to_i
	end
end

if @faculty_research
	@researches = @user.faculty_researches.order('created_at DESC')
	json.faculty_researches @researches do |research|
		json.extract! research, :id, :user_id, :title, :description, :file_type

		json.file_thumb research.thumb_url
		json.file research.file.url
		

		json.research_created_at research.created_at.to_i
		json.research_updated_at research.updated_at.to_i
	end
end

if @update_faculty_research
	json.extract! @update_faculty_research, :id, :user_id, :title, :description, :file_type

	json.file_thumb @update_faculty_research.thumb_url
	json.file @update_faculty_research.file.url

	json.research_created_at @update_faculty_research.created_at.to_i
	json.research_updated_at @update_faculty_research.updated_at.to_i
end

if @faculty_researches
	@researches = @user.faculty_researches.order('created_at DESC')
	json.faculty_researches @researches do |research|
	json.extract! research, :id, :user_id, :title, :description, :file_type

	json.file_thumb research.thumb_url
	json.file research.file.url

	json.research_created_at research.created_at.to_i
	json.research_updated_at research.updated_at.to_i
	end
end
